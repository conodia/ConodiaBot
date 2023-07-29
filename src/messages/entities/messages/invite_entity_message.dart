import 'utils/embed_entity_message.dart';
import 'utils/invite/leaderboard_invite_message.dart';
import 'utils/invite/show_invite_message.dart';

class InviteEntityMessage {
  final ShowInviteMessage show;
  final EmbedEntityMessage list;
  final EmbedEntityMessage error;
  final LeaderboardInviteMessage leaderboard;

  InviteEntityMessage(
      {required this.show,
      required this.list,
      required this.error,
      required this.leaderboard});

  factory InviteEntityMessage.from({required dynamic payload}) {
    return InviteEntityMessage(
        show: ShowInviteMessage.from(payload: payload['show']),
        list: EmbedEntityMessage.from(payload: payload['list']),
        error: EmbedEntityMessage.from(payload: payload['not_found']),
        leaderboard:
            LeaderboardInviteMessage.from(payload: payload['leaderboard']));
  }
}
