import '../moderation/mod_message.dart';
import '../moderation/unmute_message.dart';

class ModerationEntityMessage {
  final ModMessage ban;
  final ModMessage kick;
  final ModMessage mute;
  final UnMuteMessage unmute;

  ModerationEntityMessage({required this.ban, required this.kick, required this.mute, required this.unmute});

  factory ModerationEntityMessage.from({ required dynamic payload }) {
    return ModerationEntityMessage(
      ban: ModMessage.from(payload: payload['ban']),
      kick: ModMessage.from(payload: payload['kick']),
      mute: ModMessage.from(payload: payload['mute']),
      unmute: UnMuteMessage.from(payload: payload['unmute']),
    );
  }
}