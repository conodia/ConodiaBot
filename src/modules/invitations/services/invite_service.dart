import 'dart:convert';
import 'package:mineral/core/extras.dart'; 
import 'package:mineral/framework.dart';

import 'package:mineral/core/api.dart';
import 'package:http/http.dart';

import '../../../managers/api/api_http_service.dart';
import '../../../mixins/panda_mixins.dart';
import '../managers/invite_manager.dart';

class InviteService with Container, State, PandaMixins {
  Future<void> init(Guild guild) async {
    Response response = await container.use<PandaApiHttpService>().get(url: '/invites').build();
    final payload = jsonDecode(response.body);
    print(payload);

    for (dynamic invite in payload['invites']) {
      GuildMember? inviter = guild.members.cache.get(invite['user_id']);

      if(inviter == null) {
        return;
      }

      List<User> invitedUsers = [];

      for(dynamic payload in invite['invitedUsers'] ?? []) {
        User? user = guild.members.cache.get(payload['user_id'])?.user;

        if(user == null) {
          await container
              .use<PandaApiHttpService>()
              .destroy(url: "/invites/${invite['user_id']}/removeinvite/${payload['user_id']}")
              .build();
          return;
        }

        usersCache.cache.putIfAbsent(user.id, () => inviter.id);
        invitedUsers.add(user);
      }

      InviteManager inviteManager = InviteManager.from(payload: invite, guild: guild, inviter: inviter, invitedUsers: invitedUsers);
      invitesCache.cache.putIfAbsent(inviteManager.inviter.id, () => inviteManager);
    }
  }
}
