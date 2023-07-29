import 'dart:io';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';

import '../../../messages/entities/message_entity.dart';
import '../manager/ticket_manager.dart';
import '../../../utils/logs.dart';
import 'package:intl/intl.dart';

import '../utils/ticket_utils.dart';

class ButtonInteraction extends MineralEvent<ButtonCreateEvent> with Console, State, Container {
  Future<void> handle(event) async {
    if (event.channel is! PartialTextChannel) return;

    if (event.interaction.customId.equals("beforeClose")) {
      final messages = container.use<MessageEntity>().ticket;

      EmbedBuilder embedSure = EmbedBuilder(
          title: messages.close.verification.title,
          description: messages.close.verification.description,
          color: Color.invisible);

      final closeButton = ButtonBuilder.button("close")
      ..setLabel("Fermer")
      ..setStyle(ButtonStyle.danger);

      final cancelCloseButton = ButtonBuilder.button("cancelClose")
      ..setLabel("Annuler")
      ..setStyle(ButtonStyle.success);

      event.interaction.reply(embeds: [
        embedSure
      ], components: ComponentBuilder()..withButton.many([closeButton, cancelCloseButton]));
    } else if(event.interaction.customId.equals("cancelClose")) {
      EmbedBuilder embed = EmbedBuilder(
          title: "Le ticket reste ouvert.",
          color: Color.invisible);

      await event.interaction.reply(embeds: [embed], private: true);
      await event.interaction.message?.delete();
    } else if (event.interaction.customId.equals("close")) {
      PartialTextChannel channel = event.channel as PartialTextChannel;
      Map<Snowflake, Message> messages = await channel.messages.sync();

      TicketManager? ticketManager =
          TicketUtils().getTicket(channel as TextBasedChannel);

      File file = File("transcript-${channel.id}.txt");
      file.writeAsStringSync(await formatMessages(messages));

      final transcriptAttachement = AttachmentBuilder(file.readAsBytesSync(),
          description:
              "transcript du channel: ${channel.id} (${channel.label})",
          filename: "transcript-${channel.id}.txt");

      final closeEmbed = EmbedBuilder(
          title: "Ticket fermé, ${event.interaction.guild!.name}",
          description:
              "Le ticket ${channel.label} a été fermé par: ${event.interaction.user.username}\n\nVous pouvez retrouver le transcript du ticket dans les fichiers joints",
          color: Color.invisible);

      await Logs().send(LogsType.ticket, "Le ticket ${channel.label} a été fermé par: ${event.interaction.user.username}", event.interaction.guild,  transcriptAttachement);
      await ticketManager?.openUser.user.send(embeds: [closeEmbed], attachments: [transcriptAttachement]);

      // delete from cache
      if(file.existsSync()) {
        await file.delete();
      }
      await ticketManager?.delete();
      await channel.delete();
    }
  }

  Future<String> formatMessages(Map<Snowflake, Message> messages) async {
    String result = "";
    for (Message msg in messages.values.toList()) {
      String formattedDate = DateFormat.yMMMd().format(msg.createdAt) + " " + DateFormat.Hms().format(msg.createdAt);

      if (msg.content.isNotEmpty) {
        result += "$formattedDate - ${msg.author.user.username} : ${msg.content}\n";
      }

      if(msg.embeds.isNotEmpty) {
        for(EmbedBuilder embed in msg.embeds) {
          result += "\n----------EMBED----------\n";
          result += "$formattedDate - ${msg.author.user.username}\n";
          result += "Title: ${embed.title ?? "No title"}\n";
          result += "Description: ${embed.description ?? "No description"}\n";
          result += "Footer: ${embed.footer?.text}\n";
          result += "----------EMBED----------\n";
        }
      }
    }

    return result;
  }
}
