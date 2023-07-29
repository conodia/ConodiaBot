import 'package:mineral/core/api.dart';
import 'package:mineral_ioc/src/mineral_service.dart';
import '../services/type/ticket_type.dart';

class TicketSettings extends MineralService {
  final Snowflake logs;
  final Snowflake closeParent;
  final List<TicketType> types;

  TicketSettings(this.logs, this.closeParent, this.types);
}