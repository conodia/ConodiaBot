import '../embed_entity_message.dart';

class MemberMessage {
  final EmbedEntityMessage add;
  final EmbedEntityMessage remove;

  MemberMessage({required this.add, required this.remove});

  factory MemberMessage.from({ required dynamic payload }) {
    return MemberMessage(add: EmbedEntityMessage.from(payload: payload['add']), remove: EmbedEntityMessage.from(payload: payload['remove']));
  }
}
