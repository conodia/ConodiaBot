import '../../embed_entity_message.dart';

class OrderMessages {
  final EmbedEntityMessage error;
  final EmbedEntityMessage success;

  final EmbedEntityMessage conversationClient;
  final EmbedEntityMessage conversationFreelancer;

  final EmbedEntityMessage channelOpen;
  final EmbedEntityMessage embedWelcome;
  final EmbedEntityMessage embedOffers;
  final EmbedEntityMessage tos;

  final EmbedEntityMessage offerCreate;
  final EmbedEntityMessage offerAcceptDm;
  final EmbedEntityMessage offerAcceptTicket;
  final EmbedEntityMessage offerRefuseDm;

  OrderMessages({
    required this.error,
    required this.success,
    required this.conversationClient,
    required this.conversationFreelancer,
    required this.channelOpen,
    required this.tos,
    required this.offerCreate,
    required this.offerAcceptDm,
    required this.offerAcceptTicket,
    required this.offerRefuseDm,
    required this.embedWelcome,
    required this.embedOffers,
  });

  factory OrderMessages.from({ required dynamic payload }) {
    return OrderMessages(
      error: EmbedEntityMessage.from(payload: payload['error']),
      success: EmbedEntityMessage.from(payload: payload['success']),
      conversationClient: EmbedEntityMessage.from(payload: payload['conversation_client']),
      conversationFreelancer: EmbedEntityMessage.from(payload: payload['conversation_freelancer']),
      channelOpen: EmbedEntityMessage.from(payload: payload['channel_open']),
      tos: EmbedEntityMessage.from(payload: payload['tos']),
      offerCreate: EmbedEntityMessage.from(payload: payload['offer']['create']),
      offerAcceptDm: EmbedEntityMessage.from(payload: payload['offer']['accept_dm']),
      offerAcceptTicket: EmbedEntityMessage.from(payload: payload['offer']['accept']),
      offerRefuseDm: EmbedEntityMessage.from(payload: payload['offer']['refuse_dm']),
      embedWelcome: EmbedEntityMessage.from(payload: payload['welcome']),
      embedOffers: EmbedEntityMessage.from(payload: payload['offers_message']),
    );
  }
}