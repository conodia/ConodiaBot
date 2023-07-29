import 'utils/embed_entity_message.dart';
import 'utils/global/moderation_entity_message.dart';
import 'utils/global/setup_entity_message.dart';
import 'utils/global/welcome_entity_message.dart';

class GlobalEntityMessage {
  final ModerationEntityMessage moderation;
  final SetupEntityMessage setup;

  final WelcomeEntityMessage welcome;
  final EmbedEntityMessage leave;
  final EmbedEntityMessage suggestion;

  final String statsGlobal;
  final String statsConnected;

  GlobalEntityMessage({required this.moderation, required this.setup, required this.welcome, required this.suggestion, required this.statsGlobal, required this.statsConnected, required this.leave});

  factory GlobalEntityMessage.from({ required dynamic payload}) {
    return GlobalEntityMessage(
      moderation: ModerationEntityMessage.from(payload: payload['moderation']),
      setup: SetupEntityMessage.from(payload: payload['setup']),
      welcome: WelcomeEntityMessage.from(payload: payload['welcome']),
      leave: EmbedEntityMessage.from(payload: payload['leave']),
      suggestion: EmbedEntityMessage.from(payload: payload['suggestion']),
      statsGlobal: payload['channels_name']['stats_global'],
      statsConnected: payload['channels_name']['stats_online'],
    );
  }
}