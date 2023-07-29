import '../embed_entity_message.dart';

class SetupEntityMessage {
  final EmbedEntityMessage roles;
  final EmbedEntityMessage rules;

  SetupEntityMessage({required this.roles, required this.rules});

  factory SetupEntityMessage.from({ required dynamic payload }) {
    return SetupEntityMessage(
      roles: EmbedEntityMessage.from(payload: payload['roles']),
      rules: EmbedEntityMessage.from(payload: payload['rules']),
    );
  }
}