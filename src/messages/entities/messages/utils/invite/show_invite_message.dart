import '../embed_entity_message.dart';

class ShowInviteMessage {
  final EmbedEntityMessage another;
  final EmbedEntityMessage self;

  ShowInviteMessage({ required this.another, required this.self });

  factory ShowInviteMessage.from({ required dynamic payload }) {
    return ShowInviteMessage(another: EmbedEntityMessage.from(payload: payload['another']), self: EmbedEntityMessage.from(payload: payload['self']));
  }
}