import 'dart:async';

import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../../messages/entities/message_entity.dart';
import '../../../../../messages/extensions/global_string_extension.dart';
import '../../../../../messages/extensions/invite_string_extension.dart';
import '../../../../../mixins/panda_mixins.dart';
import '../../../managers/invite_manager.dart';

class ShowInvitation extends MineralSubcommand<GuildCommandInteraction> with State, Container, PandaMixins {
  ShowInvitation(): super(label: Display('show'), description: Display("Voir les invitations d'une personne"), options: [
    CommandOption.user(Display('membre'), Display("Le membre dont vous voulez voir les invitations"), required: false)
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    User? user = interaction.getUser("membre");

    if (user == null) {
      user = interaction.user;
    }
    InviteManager? inviteManager = invitesCache.cache.get(user.id);
    final messages = container.use<MessageEntity>().invites;

    if (inviteManager == null) {
      final errorEmbed = EmbedBuilder(
          title: messages.error.title.reUser(user),
          description: messages.error.description.reUser(user),
          color: Color.invisible);
      await interaction.reply(embeds: [errorEmbed], private: true);
      return;
    }

    final embed = EmbedBuilder(
        title: "${user == interaction.user ? messages.show.self.title.reInvite(inviteManager).reUser(user) : messages.show.another.title.reInvite(inviteManager).reUser(user)}",
        description: "${user == interaction.user ? messages.show.self.description.reInvite(inviteManager).reUser(user) : messages.show.another.description.reInvite(inviteManager).reUser(user)}",
        color: Color.invisible
    );

    await interaction.reply(embeds: [embed], private: true);
  }
}
