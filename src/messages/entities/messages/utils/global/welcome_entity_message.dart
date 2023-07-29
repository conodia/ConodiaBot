import '../embed_entity_message.dart';

class WelcomeEntityMessage {
  final EmbedEntityMessage normal;
  final EmbedEntityMessage vanity;

  WelcomeEntityMessage({ required this.normal, required this.vanity});

  factory WelcomeEntityMessage.from({ required dynamic payload }) {
    return WelcomeEntityMessage(normal: EmbedEntityMessage.from(payload: payload['normal']), vanity: EmbedEntityMessage.from(payload: payload['vanity']));
  }
}