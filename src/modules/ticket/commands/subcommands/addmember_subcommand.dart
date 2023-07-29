import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../messages/entities/message_entity.dart';
import '../../../../messages/extensions/global_string_extension.dart';
import '../../utils/ticket_utils.dart';

class AddMemberSubCommand extends MineralSubcommand<GuildCommandInteraction> with State, Container {
  AddMemberSubCommand(): super(label: Display("addmember"), description: Display("addmember_description"), options: [
    CommandOption.user(Display("membre"), Display("Le membre à ajouter"), required: true)
  ]);
  
  Future<void> handle (CommandInteraction interaction) async {
    final memberToAdd = interaction.getMember("membre")!;
    final messages = container.use<MessageEntity>().ticket;

    TextChannel channel = interaction.guild!.channels.cache.getOrFail(interaction.channel!.id);
    if(channel is TextChannel) {
      if(TicketUtils().isTicket(channel)) {
          await channel.setPermissionsOverwrite([
            PermissionOverwrite(id: memberToAdd.id, type: PermissionOverwriteType.member, allow: [ClientPermission.sendMessages, ClientPermission.viewChannel, ClientPermission.attachFiles])
          ]);

          final embed = EmbedBuilder(
            title: messages.member.add.title.reUser(memberToAdd.user),
            description: messages.member.add.description.reUser(memberToAdd.user),
            color: Color.invisible
          );

          await interaction.reply(embeds: [embed], private: true);
      } else {
        await interaction.reply(content: messages.notTicket, private: true);
      }
    }
  }
}