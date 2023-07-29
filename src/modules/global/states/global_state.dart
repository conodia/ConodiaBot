import 'package:mineral/framework.dart';

import '../settings/global_settings.dart';

class GlobalState extends MineralState<GlobalSettings> {
  GlobalState(): super(GlobalSettings(
    activity: "",
    guildId: null,
    verifiedRole: "",
    welcomeChannel: "",
    leaveChannel: "",
    ));

  void setConfiguration (GlobalSettings configuration) => state = configuration;
}