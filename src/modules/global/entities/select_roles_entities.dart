import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';

class SelectRoles {
  final Snowflake id;
  final String label;
  final EmojiBuilder emoji;

  SelectRoles(this.id, this.label, this.emoji);
}