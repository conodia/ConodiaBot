import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../managers/api/api_manager.dart';
import '../modules/verification/websocket_modules/staff_connexion.dart';
import '../modules/verification/websocket_modules/verify_user.dart';
import '../websocket/modules/auth.dart';
import '../websocket/modules/heartbeat.dart';
import '../websocket/websocket_bot.dart';

class ReadyWebsocket extends MineralEvent<ReadyEvent> with  Console {
  Future<void> handle(event) async {

    /**
     * Init API
     */

    dynamic payload = await Api().init();

    /**
     * Init WebSocket
     */

    final websocket = WebSocketBot([
      AuthModule(),
      HeartModule(),
      VerifyUserModule(),
      StaffConnexionModule(),
    ]);

    await websocket.init(payload);
  }
}


