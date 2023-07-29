import 'dart:async';

import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';
import '../../../../../mixins/panda_mixins.dart';
import '../../../managers/leaderboard_manager.dart';

class LeaderboardInvitation extends MineralSubcommand<GuildCommandInteraction> with State, Container, PandaMixins {
  LeaderboardInvitation(): super(label: Display('leaderboard'), description: Display('Voir le classement global des invitations'));

  Future<void> handle(CommandInteraction interaction) async {
    LeaderboardManager leaderboardManager = LeaderboardManager(invites: invitesCache.cache);
    await interaction.channel?.cast<TextBasedChannel>().send(embeds: [leaderboardManager.first()], components: leaderboardManager.getComponents(1));

    await interaction.deferredReply();
    await interaction.delete();
  }
}
