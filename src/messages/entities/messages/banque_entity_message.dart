import 'utils/embed_entity_message.dart';

class BanqueEntityMessage {
  final EmbedEntityMessage error;
  final EmbedEntityMessage acceptedWithdraw;
  final EmbedEntityMessage deniedWithdraw;
  final EmbedEntityMessage requestWithdraw;

  final EmbedEntityMessage show;
  final EmbedEntityMessage me;
  final EmbedEntityMessage add;

  BanqueEntityMessage({
    required this.error,
    required this.acceptedWithdraw,
    required this.deniedWithdraw,
    required this.requestWithdraw,
    required this.show,
    required this.me,
    required this.add,
  });

  factory BanqueEntityMessage.from({required final payload}) {
    return BanqueEntityMessage(
      error: EmbedEntityMessage.from(payload: payload['error']),
      acceptedWithdraw: EmbedEntityMessage.from(payload: payload['acceptedWithdraw']),
      deniedWithdraw: EmbedEntityMessage.from(payload: payload['deniedWithdraw']),
      requestWithdraw: EmbedEntityMessage.from(payload: payload['requestWithdraw']),
      show: EmbedEntityMessage.from(payload: payload['show']),
      add: EmbedEntityMessage.from(payload: payload['add']),
      me: EmbedEntityMessage.from(payload: payload['me']),
    );
  }
}