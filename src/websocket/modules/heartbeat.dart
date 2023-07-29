import 'dart:io';

import '../../utils/utils.dart';
import '../contracts/websocket_contract.dart';
import '../websocket_bot.dart';

class HeartModule extends WebSocketContract {
  @override
  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data) async {
    if(data['status'] == 401) {
      Utils.printError("------------------------------------------------------------------------------------");
      Utils.printError("                               Une erreur est survenue !");
      Utils.printError("                  Vérifiez votre licence, ou redémarrez le bot ou contactez Panda_Guerrier#3080 !");
      Utils.printError("------------------------------------------------------------------------------------");
      exit(0);
    }
  }

  @override
  // TODO: implement type
  WCode get type => WCode.HEARTBEAT;
}
