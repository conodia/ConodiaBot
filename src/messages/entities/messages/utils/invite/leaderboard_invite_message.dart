import '../embed_entity_message.dart';

class LeaderboardInviteMessage {
  final EmbedEntityMessage message;
  final String format;

  LeaderboardInviteMessage({ required this.message, required this.format});

  factory LeaderboardInviteMessage.from({ required dynamic payload }) {
    return LeaderboardInviteMessage(message: EmbedEntityMessage.from(payload: payload), format: payload['format']);
  }
}