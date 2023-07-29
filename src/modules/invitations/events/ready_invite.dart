import 'dart:async';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';
import '../../global/states/global_state.dart';
import '../cache/invite_cache.dart';
import '../cache/users_settings.dart';
import '../services/invite_service.dart';

class ReadyInvite extends MineralEvent<ReadyEvent> with State {
  Future<void> handle (event) async {
    final settings = states.use<GlobalState>().state;

    InvitePandaCache();
    UsersCache();

    Timer(Duration(seconds: 3), () async {
      Guild guild = event.client.guilds.cache.getOrFail(settings.guildId);
      await InviteService().init(guild);
    });
  }
}