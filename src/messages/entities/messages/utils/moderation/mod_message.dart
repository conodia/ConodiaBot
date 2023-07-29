import '../embed_entity_message.dart';
import 'contracts/moderation_contract.dart';

class ModMessage extends ModerationContract {
  ModMessage({required EmbedEntityMessage user, required EmbedEntityMessage reply}) : super(user: user, reply: reply);

  factory ModMessage.from({ required dynamic payload }) {
    return ModMessage(
      user: EmbedEntityMessage.from(payload: payload['user']),
      reply: EmbedEntityMessage.from(payload: payload['reply']),
    );
  }
}