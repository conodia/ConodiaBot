import '../embed_entity_message.dart';

class TicketMessage {
  final EmbedEntityMessage open;
  final String channelSendMessageTitle;

  TicketMessage({required this.open, required this.channelSendMessageTitle});

  factory TicketMessage.from({ required dynamic payload }) {
    return TicketMessage(open: EmbedEntityMessage.from(payload: payload['open']), channelSendMessageTitle: payload['channel_send_title']);
  }
}