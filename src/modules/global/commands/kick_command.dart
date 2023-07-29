import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';


class KickCommand extends MineralCommand with Container {
  KickCommand(): super(label: Display('kick'), description: Display('Kick un membre'), permissions: [ClientPermission.kickMembers, ClientPermission.administrator], options: [
        CommandOption.user(Display('membre'), Display('Kick le membre séléctionné'), required: true),
        CommandOption.string(Display('raison'), Display('La raison du kick'), required: true)
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    final member = interaction.getMember('membre')!;
    final reason = interaction.getValue<String>('raison');
    final messages = container.use<MessageEntity>().global.moderation;

    final embedKickedMember = EmbedBuilder(
        title: messages.kick.user.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
        description: messages.kick.user.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
        color: Color.red_500);

    final embedSuccessKick = EmbedBuilder(
        title: messages.kick.reply.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
        description: messages.kick.reply.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
        color: Color.invisible);

    await member.user.send(embeds: [embedKickedMember]);
    await interaction.reply(embeds: [embedSuccessKick], private: true);
    await member.kick(count: 7, reason: reason);
  }
}
