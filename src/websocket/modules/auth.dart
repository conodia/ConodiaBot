import 'dart:io';

import 'package:mineral/core/extras.dart';

import '../contracts/websocket_contract.dart';
import '../websocket_bot.dart';

class AuthModule extends WebSocketContract with Console {
  @override
  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data) async {
    switch (data['status']) {
      case 200:
        console.success("------------------------------------------------------------------------------------");
        console.success("                               L'authentification a réussie");
        console.success("------------------------------------------------------------------------------------");
        break;
      case 401:
        console.error("------------------------------------------------------------------------------------");
        console.error("                               L'authentification a échouée");
        console.error("                  Vérifiez votre licence, ou contactez Panda_Guerrier#3080 !");
        console.error("                 Votre licence est peut-être invalide, ou déjà utilisé !");
        console.error("------------------------------------------------------------------------------------");
        exit(0);
    }
  }

  @override
  WCode get type => WCode.AUTH;
}
