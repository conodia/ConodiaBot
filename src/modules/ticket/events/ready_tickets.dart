import 'dart:async';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';
import '../../../mixins/panda_mixins.dart';
import '../../global/states/global_state.dart';
import '../cache/ticket_cache.dart';

class ReadyTickets extends MineralEvent<ReadyEvent> with State, Container, PandaMixins {
  Future<void> handle (event) async {
    Timer(Duration(seconds: 3), () async {
      final settings = states.use<GlobalState>().state;
      TicketCache();
      Guild guild = await container.use<MineralClient>().guilds.cache.getOrFail(settings.guildId);
      await ticketsCache.sync(guild);
    });
  }
}

