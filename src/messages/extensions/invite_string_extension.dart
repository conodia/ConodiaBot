import 'package:mineral/core/api.dart';
import 'package:mineral/src/api/invites/invite.dart';
import '../../modules/invitations/managers/invite_manager.dart';

extension StringExtension on String {

  /*
  *
  *  invites
  *
  *
  *  */

  String reInvite(InviteManager inviteManager) {
    return this.reInviter(inviteManager).reInvites(inviteManager);
  }

  String reInviter(InviteManager inviteManager) {
    return this.replaceAll("{inviter}", inviteManager.inviter.toString()).replaceAll("{inviter.username}", inviteManager.inviter.user.username).replaceAll("{inviter.tag}", inviteManager.inviter.user.tag);
  }

  String reInvites(InviteManager inviteManager) {
    return this.replaceAll("{actual}", inviteManager.actual.toString()).replaceAll("{total}", inviteManager.total.toString()).replaceAll("{leaves}", inviteManager.leaves.toString()).replaceAll("{bonus}", inviteManager.bonus.toString());
  }

  String reVanity(Guild guild) {
    return this.replaceAll("{code}", guild.vanity?.code ?? "none");
  }

  String reCode(Invite invite) {
    return this.replaceAll("{code}", invite.code);
  }

  String reList(InviteManager inviteManager) {
    String listedUsers = inviteManager.invitedUsers.map((user) => "$user (${user.id})").join(", ");
    return this.replaceAll("{list}", listedUsers);
  }

  String reLbUsers(int index, InviteManager inviteManager) {
    return this.replaceAll("{index}", index.toString()).reInvites(inviteManager);
  }

  String rePage(int actualIndex, List<InviteManager> list) {
    // get the index of the last page
    int lastIndex = (list.length / 10).ceil();
    return this.replaceAll("{page}", actualIndex.toString()).replaceAll("{max_page}", lastIndex.toString());
  }
}