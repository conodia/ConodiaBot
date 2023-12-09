import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mineral/core/extras.dart';

import '../panda/panda_constants.dart';
import '../utils/debug.dart';
import '../utils/utils.dart';
import 'contracts/websocket_contract.dart';

class WebSocketBot with State, Environment, Client {
  WebSocketFactory modules;
  late WebSocket webSocket;

  WebSocketBot(this.modules);

  Future<void> init(dynamic payload) async {
    this.webSocket = await WebSocket.connect(PandaConstant.baseWs);
    print("WebSocket connecté !");

    this.webSocket.handleError((err) => {Debug().error(err)});

    /**
     * Authenticate to websocket
     */

    await send(code: WCode.AUTH, data: payload);

    /**
     * Listen to websocket and handle modules
     */

    await this.webSocket.listen((event) async {
      JsonDecoder decoder = new JsonDecoder();
      Map<String, dynamic> json = decoder.convert(event.toString());

      if (environment.get("WEBSOCKET") == "debug") {
        final date = DateTime.now();
        print(json.toString() +
            " TIME: ${date.hour}, ${date.minute}: ${date.second}");
      }

      for (var module in modules) {
        if (module.type.value == json['type'])
          await module.handle(this.webSocket, json);
      }
    });

    /**
     * Send heartbeat to websocket
     */

    Timer.periodic(new Duration(seconds: 40),
        (timer) => send(code: WCode.HEARTBEAT, data: '"bot_id": "${client.user.id}"'));

    /**
     * Check if websocket is closed
     */

    await this.webSocket.done;

    Utils.printError(
        "------------------------------------------------------------------------------------");
    Utils.printError(
        "                               Une erreur est survenue !");
    Utils.printError(
        "                  Vérifiez votre token, ou redémarrez le bot ou contactez Panda_Guerrier#3080 !");
    Utils.printError(
        "------------------------------------------------------------------------------------");
    exit(0);
  }

  Future<void> send({required WCode code, required dynamic data}) async {
    this.webSocket.add(jsonEncode({
      "code": code.value,
      "data": data,
    }));
  }
}

enum WCode {
  AUTH(0),
  HEARTBEAT(1),
  VERIFIED_USER(3),
  STAFF_CONNEXION(4),
  EMERGENCY_REQUEST(8);

  final int value;
  const WCode(this.value);
}
