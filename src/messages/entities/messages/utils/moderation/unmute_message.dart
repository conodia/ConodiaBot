import '../embed_entity_message.dart';
import 'contracts/moderation_contract.dart';

class UnMuteMessage extends ModerationContract {
  final EmbedEntityMessage fail;

  UnMuteMessage( {required EmbedEntityMessage user, required EmbedEntityMessage reply, required this.fail} ) : super(user: user, reply: reply);

  factory UnMuteMessage.from({ required dynamic payload }) {
    return UnMuteMessage(
      user: EmbedEntityMessage.from(payload: payload['user']),
      reply: EmbedEntityMessage.from(payload: payload['reply']),
      fail: EmbedEntityMessage.from(payload: payload['fail']),
    );
  }
}