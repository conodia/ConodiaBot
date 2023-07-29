import 'utils/embed_entity_message.dart';

class GiveawayEntityMessage {
  final EmbedEntityMessage create;
  final EmbedEntityMessage notExist;
  final EmbedEntityMessage victory;
  final EmbedEntityMessage victorySendUser;
  final EmbedEntityMessage noWinners;
  final EmbedEntityMessage end;

  final String buttonGo;

  GiveawayEntityMessage({
      required this.create,
      required this.notExist,
      required this.victory,
      required this.victorySendUser,
      required this.noWinners,
      required this.end,
      required this.buttonGo
  });

  factory GiveawayEntityMessage.from({required dynamic payload}) {
    return GiveawayEntityMessage(
        create: EmbedEntityMessage(title: payload['create']['title'], description: payload['create']['description']),
        notExist: EmbedEntityMessage(title: payload['not_exist']['title'], description: payload['not_exist']['description']),
        victory: EmbedEntityMessage(title: payload['victory']['title'], description: payload['victory']['description']),
        victorySendUser: EmbedEntityMessage(title: payload['victory_send_user']['title'], description: payload['victory_send_user']['description']),
        noWinners: EmbedEntityMessage(title: payload['no_winners']['title'], description: payload['no_winners']['description']),
        end: EmbedEntityMessage(title: payload['end']['title'], description: payload['end']['description']),
        buttonGo: payload['buttons']['go_to_giveaway']);
  }
}
