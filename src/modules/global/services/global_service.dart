import 'dart:io';

import 'package:mineral/core/extras.dart';
import 'package:mineral_ioc/src/mineral_service.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../../../managers/config_manager.dart';
import '../../../panda/panda_constants.dart';
import '../settings/global_settings.dart';
import '../states/global_state.dart';

class GlobalService extends MineralService with Console, State {
  File settingsFile = File(join(Directory.current.path, "config", "config.yml"));

  GlobalService() : super(inject: true) {
      init();
  }

  void init() async {
    if (!settingsFile.existsSync()) {
      settingsFile = await ConfigManager().downloadFile(PandaConstant.globalUrl, "config.yml");
    }

    dynamic settings = loadYaml(settingsFile.readAsStringSync());
    final globalState = states.use<GlobalState>();

    globalState.setConfiguration(GlobalSettings(
        activity: settings['activity'],
        guildId: settings['server_id'],
        verifiedRole: settings['roles']['verified_role'],
        welcomeChannel: settings['channels']['welcome'],
        leaveChannel: settings['channels']['leave'],
    ));
  }
}
