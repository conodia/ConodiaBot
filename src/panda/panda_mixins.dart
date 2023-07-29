import 'package:mineral_ioc/ioc.dart';

import '../messages/entities/message_entity.dart';

mixin PandaUtils {
  MessageEntity get messages => ioc.use<MessageEntity>();
}