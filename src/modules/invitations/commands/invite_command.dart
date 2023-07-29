import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';
import 'subcommands/invite/leaderboard_invitation.dart';
import 'subcommands/invite/list_invitation.dart';
import 'subcommands/invite/show_invitation.dart';

class InviteCommand extends MineralCommand<GuildCommandInteraction> {
  InviteCommand(): super(label: Display('invite'), description: Display('Gérer les invitations'), permissions: [ClientPermission.administrator], subcommands: [
    ShowInvitation(),
    LeaderboardInvitation(),
    ListInvitation()
    ]);
}
                                                                         // Ici c'est une mixin, qui sert a avoir un "raccourcis" pour une function / getter (en général c'est un getter)
