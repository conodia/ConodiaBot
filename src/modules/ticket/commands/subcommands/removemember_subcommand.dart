import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../messages/entities/message_entity.dart';
import '../../../../messages/extensions/global_string_extension.dart';
import '../../utils/ticket_utils.dart';

class RemoveMemberSubCommand extends MineralSubcommand<GuildCommandInteraction> with State, Container {
  RemoveMemberSubCommand(): super(label: Display("removemember"), description: Display("Enlever un membre au ticket"), options: [
    CommandOption.user(Display("membre"), Display("Le membre à enlever"), required: true)
  ]);
  
  Future<void> handle (CommandInteraction interaction) async {
    final memberToRemove = interaction.getMember("membre")!;
    final messages = container.use<MessageEntity>().ticket;

    TextChannel channel = interaction.guild!.channels.cache.getOrFail(interaction.channel!.id);
    if(channel is TextChannel) {
      if(TicketUtils().isTicket(channel)) {
        await channel.setPermissionsOverwrite([
          PermissionOverwrite(id: memberToRemove.id, type: PermissionOverwriteType.member, deny: [ClientPermission.sendMessages,
            ClientPermission.viewChannel, ClientPermission.attachFiles])
        ]);
        final embed = EmbedBuilder(
            title: messages.member.remove.title.reUser(memberToRemove.user),
            description: messages.member.remove.description.reUser(memberToRemove.user),
            color: Color.invisible
        );

        await interaction.reply(embeds: [embed], private: true);
      } else {
        await interaction.reply(content: messages.notTicket, private: true);
      }
    }
  }
}