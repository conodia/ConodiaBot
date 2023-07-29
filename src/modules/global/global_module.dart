import 'package:mineral_contract/mineral_contract.dart';

import 'commands/ban_command.dart';
import 'commands/kick_command.dart';
import 'commands/mute_command.dart';
import 'commands/un_mute_command.dart';
import 'events/button_rules_interaction.dart';
import 'events/member_join.dart';
import 'services/global_service.dart';
import 'states/global_state.dart';

class GlobalModule extends MineralPackageContract {
  GlobalModule (): super('Global', 'Global desc');
  
  @override
  Future<void> init () async {
    commands.register([
      BanCommand(),
      KickCommand(),
      MuteCommand(),
      UnMuteCommand(),
    ]);
    events.register([
      ButtonRulesInteraction(),
      MemberJoin(),
    ]);
    contextMenus.register([]);
    states.register([
      GlobalState(),
    ]);
    GlobalService();
  }
}