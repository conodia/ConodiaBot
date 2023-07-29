import 'dart:async';

import 'package:mineral/core/builders.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../../messages/entities/message_entity.dart';
import '../../../../messages/extensions/giveaway_string_extension.dart';
import '../../managers/giveaway_manager.dart';

class CreateGiveaway extends MineralSubcommand<GuildCommandInteraction> with State, Container {
  CreateGiveaway(): super(label: Display("create"), description: Display("Créer un giveaway"), options: [
    CommandOption.string(Display("nom"), Display("Le nom du giveaway"), required: true),
    CommandOption.string(Display("description"), Display("La description du giveaway"), required: true),
    CommandOption.string(Display("lot"), Display("Le lot du giveaway"), required: true),
    CommandOption.channel(Display("channel"), Display("Le channel où poster le giveaway"), required: true),
    CommandOption.double(Display("max_gagnants"), Display("Le nombre de gagnants"), required: true),
    CommandOption.double(Display("durée_jours"), Display("Le nombre de jours"), required: true),
    CommandOption.double(Display("durée_heures"), Display("Le nombre d'heures"), required: true),
    CommandOption.double(Display("durée_minutes"), Display("Le nombre de minutes"), required: true),

  ]);

  Future<void> handle(CommandInteraction interaction) async {
    final name = interaction.getValue<String>("nom");
    final description = interaction.getValue<String>("description").replaceAll(
        "%ligne%", "\n");
    final lot = interaction.getValue<String>("lot");
    final channel = interaction.getChannel("channel");
    final maxWinners = interaction.getValue<int>("max_gagnants");
    final daysDuration = interaction.getValue<int>("durée_jours");
    final hoursDuration = interaction.getValue<int>("durée_heures");
    final minutesDuration = interaction.getValue<int>("durée_minutes");
    if(channel is! TextChannel) {
      await interaction.reply(content: "Merci de saisir un channel textuel.", private: true);
      return;
    }

    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;
    int endTimestamp = DateTime.now().add(Duration(days: daysDuration, hours: hoursDuration, minutes: minutesDuration)).millisecondsSinceEpoch;
    String buttonId = "giveaway_" + nowTimestamp.toString();

    final messages = container.use<MessageEntity>().giveaway;

    if (maxWinners == 0) {
      await interaction.reply(content: "Merci de saisir un nombre de gagnants supérieur ou égal à **1**.", private: true);
      return;
    }
    GiveawayManager giveaway = GiveawayManager(
        name,
        description,
        channel.id,
        lot,
        endTimestamp,
        nowTimestamp,
        maxWinners,
        buttonId,
        [],
        interaction.guild!
    );


    final embed = EmbedBuilder(
        title: messages.create.title.reGiveaway(giveaway),
        description: messages.create.description.reGiveaway(giveaway),
        color: Color.invisible
    );

    final button = ButtonBuilder.button(buttonId)
      ..setStyle(ButtonStyle.success)
      ..setLabel("Participer")
      ..setEmoji(EmojiBuilder.fromUnicode("🎉"));

    Message? message = await channel.send(
        embeds: [embed], components: ComponentBuilder()
      ..withButton.many([button]));

    giveaway.setMessageId(message!.id);
    giveaway.create(daysDuration, hoursDuration, minutesDuration);

    await interaction.reply(
        content: "C'est bon le giveaway est lancé !", private: true);
  }

  int getDuration(int days, int hours, int minutes) {
    final now = (DateTime
        .now()
        .millisecondsSinceEpoch + DateTime
        .now()
        .millisecond) / 1000;
    return now.round() + (days * 86400) + (hours * 3600) + (minutes * 60);
  }
}