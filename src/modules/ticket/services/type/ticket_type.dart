import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral_ioc/src/mineral_service.dart';

class TicketType extends MineralService {
    final String id;
    final String name;
    final String description;
    final EmojiBuilder emoji;
    final Snowflake parentId;
    final String welcomeMessage;
    final List<Snowflake> roles;

    TicketType(this.id, this.name, this.description, this.emoji, this.parentId, this.welcomeMessage, this.roles);
}