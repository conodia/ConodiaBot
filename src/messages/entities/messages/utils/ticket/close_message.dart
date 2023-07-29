import '../embed_entity_message.dart';

class CloseMessage {
  final EmbedEntityMessage verification;
  final EmbedEntityMessage cancel;
  final EmbedEntityMessage close;

  CloseMessage({required this.verification, required this.cancel, required this.close});

  factory CloseMessage.from({ required dynamic payload }) {
    return CloseMessage(verification: EmbedEntityMessage.from(payload: payload['verification']), cancel: EmbedEntityMessage.from(payload: payload['cancel']), close: EmbedEntityMessage.from(payload: payload['close']));
  }
}
