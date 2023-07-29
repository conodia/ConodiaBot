import 'dart:io';

import '../websocket_bot.dart';

typedef WebSocketFactory = List<WebSocketContract>;

abstract class WebSocketContract {
  WCode get type;

  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data);
}