import '../../embed_entity_message.dart';

abstract class ModerationContract {
  final EmbedEntityMessage user;
  final EmbedEntityMessage reply;

  ModerationContract({required this.user, required this.reply});
}
