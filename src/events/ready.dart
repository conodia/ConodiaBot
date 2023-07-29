import 'package:mineral/core/api.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../modules/global/states/global_state.dart';

class Ready extends MineralEvent<ReadyEvent> with Console, State {
  Future<void> handle(event) async {
    final settings = states.use<GlobalState>().state;
    event.client.setPresence(activity: ClientActivity(name: settings.activity, type: GamePresence.game));
  }
}


