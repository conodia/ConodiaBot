import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';


class UnMuteCommand extends MineralCommand with  Container {
  UnMuteCommand(): super(label: Display('unmute'), description: Display('Unmute un membre'), permissions: [ClientPermission.muteMembers, ClientPermission.administrator], options: [
    CommandOption.user(Display('membre'), Display('Unmute le membre séléctionné'), required: true)
  ]);
  
  Future<void> handle (CommandInteraction interaction) async {
    final member = interaction.getMember("membre")!;
    final messages = container.use<MessageEntity>().global.moderation;

    final embedSuccess = EmbedBuilder(
        title: messages.unmute.reply.title.reModeration(member.user, "", interaction.user, interaction.guild!),
        description: messages.unmute.reply.description.reModeration(member.user, "", interaction.user, interaction.guild!),
        color: Color.invisible
    );

    final embedMemberUnmuted = EmbedBuilder(
        title: messages.unmute.user.title.reModeration(member.user, "", interaction.user, interaction.guild!),
        description: messages.unmute.user.description.reModeration(member.user, "", interaction.user, interaction.guild!),
        color: Color.invisible
    );

    final embedFailedUnmute = EmbedBuilder(
        title: messages.unmute.fail.title.reModeration(member.user, "", interaction.user, interaction.guild!),
        description: messages.unmute.fail.description.reModeration(member.user, "", interaction.user, interaction.guild!),
        color: Color.red_500
    );

    if(member.timeoutDuration == null) {
      await interaction.reply(embeds: [embedFailedUnmute], private: true);
    } else {
      await interaction.reply(embeds: [embedSuccess], private: true);
      await member.user.send(embeds: [embedMemberUnmuted]);
      await member.removeTimeout();
    }
  }
}