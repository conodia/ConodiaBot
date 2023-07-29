import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';

import '../manager/ticket_manager.dart';
import '../services/type/ticket_type.dart';
import '../utils/ticket_utils.dart';

class MenuInteraction extends MineralEvent<DynamicMenuCreateEvent> with State, Console, Container {
  Future<void> handle(event) async {
    if (!event.interaction.customId.equals("ticket")) return;

    final messages = container.use<MessageEntity>().ticket;
    Message message = event.interaction.message as Message;
    TicketType ticketType =
        TicketUtils().getTicketType(event.interaction.menu.getValue());
    final List<PermissionOverwrite> rolesPermission = [
      ...ticketType.roles.map((e) => PermissionOverwrite(
          id: e,
          type: PermissionOverwriteType.role,
          allow: [ClientPermission.viewChannel, ClientPermission.sendMessages]))
    ];

    await message.edit(
        embeds: [TicketUtils().embed()],
        components: ComponentBuilder()
          ..withSelectMenu(TicketUtils().selectMenu()));

    if (TicketUtils().isAlreadyOpen(event.member)) {
      await event.interaction
          .reply(content: messages.alreadyOpen, private: true);
      return;
    }

    TextChannel? channel = await event.interaction.guild!.channels.create(
        ChannelBuilder.fromTextChannel(
            label:
                ticketType.emoji.emoji.label + "┃" + event.member.user.username,
            parentId: ticketType.parentId,
            permissions: [
          ...rolesPermission,
          PermissionOverwrite(
              id: event.member.id,
              type: PermissionOverwriteType.member,
              allow: [
                ClientPermission.viewChannel,
                ClientPermission.sendMessages,
                ClientPermission.attachFiles
              ]),
          PermissionOverwrite(
              id: event.interaction.guild!.roles.everyone.id,
              type: PermissionOverwriteType.role,
              deny: [
                ClientPermission.viewChannel,
                ClientPermission.sendMessages,
                ClientPermission.attachFiles
              ])
        ]));

    await channel!.setDescription(ticketType.id + event.member.id);

    final embedWelcome = EmbedBuilder(
      title: messages.ticket.channelSendMessageTitle,
      description: ticketType.welcomeMessage,
      color: Color.invisible,
    );

    final closeButton = ButtonBuilder.button("beforeClose")
      ..setLabel("Fermer")
      ..setStyle(ButtonStyle.danger)
      ..setEmoji(EmojiBuilder.fromUnicode("🗑"));

    await channel.send(
        content: "<@" + event.interaction.user.id + ">",
        embeds: [embedWelcome],
        components: ComponentBuilder()..withButton.many([closeButton]));

    TicketManager ticketManager =
        TicketManager(channel, ticketType, event.member);
    await ticketManager.create();

    EmbedBuilder embed = EmbedBuilder(
      title: messages.ticket.open.title.reChannel(channel),
      description: messages.ticket.open.description.reChannel(channel),
      color: Color.invisible,
    );

    event.interaction.reply(embeds: [embed], private: true);
  }
}
