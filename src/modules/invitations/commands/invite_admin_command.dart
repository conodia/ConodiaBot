import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import 'subcommands/invite_admin/add_invitation.dart';
import 'subcommands/invite_admin/remove_invitation.dart';
import 'subcommands/invite_admin/set_invitation.dart';

class InviteAdminCommand extends MineralCommand<GuildCommandInteraction> {
  InviteAdminCommand(): super(label: Display('inviteadmin'), description: Display('Ajouter, supprimer ou définir des invitations'), permissions: [ClientPermission.administrator], subcommands: [
    AddInvitation(),
    RemoveInvitation(),
    SetInvitation()
  ]);
}

/*


    todo: ajouter le /invite list member: pour voir les membres qu'il a invité, faire les messages, ajouter le message de départ

*  */
