import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';


class BanCommand extends MineralCommand with Container {
  BanCommand(): super(label: Display('ban'), description: Display('Ban un membre'), permissions: [ClientPermission.banMembers, ClientPermission.administrator], options: [
    CommandOption.user(Display('membre'), Display('Ban le membre séléctionné'), required: true),
    CommandOption.string(Display('raison'), Display('La raison du ban'), required: true)
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    final member = interaction.getMember('membre')!;
    final reason = interaction.getValue<String>('raison');
    final messages = container.use<MessageEntity>().global.moderation;

    final embedBannedMember = EmbedBuilder(
        title: messages.ban.user.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
        description: messages.ban.user.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
        color: Color.red_500);

    final embedSuccessBan = EmbedBuilder(
        title: messages.ban.reply.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
        description: messages.ban.reply.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
        color: Color.invisible);

    await member.user.send(embeds: [embedBannedMember]);
    await interaction.reply(embeds: [embedSuccessBan], private: true);
    await member.ban(count: 7, reason: reason);
  }
}
