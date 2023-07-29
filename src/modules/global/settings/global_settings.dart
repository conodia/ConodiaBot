
import 'package:mineral/core/api.dart';
import 'package:mineral_ioc/src/mineral_service.dart';

class GlobalSettings extends MineralService {
  final Snowflake? guildId;
  final Snowflake verifiedRole;
  final Snowflake welcomeChannel;
  final String activity;
  final Snowflake leaveChannel;

  GlobalSettings({ required this.activity, required this.guildId, required this.verifiedRole, required this.welcomeChannel, required this.leaveChannel});
}