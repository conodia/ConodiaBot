import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';


class MuteCommand extends MineralCommand with Container {
  MuteCommand(): super(label: Display('mute'), description: Display('Mute un membre'), permissions: [ClientPermission.muteMembers, ClientPermission.administrator], options: [
    CommandOption.user(Display('membre'), Display('Mute le membre séléctionné'), required: true),
    CommandOption.integer(Display('jours'), Display('Le nombre de jours du mute'), required: true),
    CommandOption.integer(Display('heures'), Display('Le nombre de heures du mute'), required: true),
    CommandOption.integer(Display('minutes'), Display('Le nombre de minutes du mute'), required: true),
    CommandOption.string(Display('raison'), Display('La raison du mute'), required: true)
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    GuildMember member = interaction.getMember("membre")!;
    final reason = interaction.getValue<String>("raison");
    final daysDuration = interaction.getValue<int>("jours");
    final hoursDuration = interaction.getValue<int>("heures");
    final minutesDuration = interaction.getValue<int>("minutes");
    final messages = container.use<MessageEntity>().global.moderation;

    final embedSuccess = EmbedBuilder(
      title: messages.mute.reply.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
      description: messages.mute.reply.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
      color: Color.invisible
    );

    final embedMemberMuted = EmbedBuilder(
        title: messages.mute.user.title.reModeration(member.user, reason, interaction.user, interaction.guild!),
        description: messages.mute.user.description.reModeration(member.user, reason, interaction.user, interaction.guild!),
        color: Color.invisible
    );

    await interaction.reply(embeds: [embedSuccess], private: true);
    await member.user.send(embeds: [embedMemberMuted]);
    await member.timeout(DateTime.now().add(Duration(days: daysDuration, hours: hoursDuration - 1, minutes: minutesDuration)));
  }
}
