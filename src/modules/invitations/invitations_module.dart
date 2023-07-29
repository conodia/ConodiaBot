import 'package:mineral_contract/mineral_contract.dart';

import 'commands/invite_admin_command.dart';
import 'commands/invite_command.dart';
import 'events/invite_leaderboard_interaction.dart';
import 'events/invite_member_join.dart';
import 'events/invite_member_leave.dart';
import 'events/ready_invite.dart';

class InvitationsModule extends MineralPackageContract {
  InvitationsModule (): super('Invitations', "Le module d'invitation");
  
  @override
  Future<void> init () async {
    commands.register([
      InviteCommand(),
      InviteAdminCommand(),
    ]);
    events.register([
      InviteMemberJoin(),
      InviteMemberLeave(),
      ReadyInvite(),
      InviteLeaderboardInteraction(),
    ]);
    contextMenus.register([]);
    states.register([]);
  }
}