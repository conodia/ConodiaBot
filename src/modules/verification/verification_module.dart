import 'package:mineral_contract/mineral_contract.dart';

import 'commands/setup_verification.dart';
import 'commands/unlink.dart';
import 'events/button_staff_connexion_interaction.dart';
import 'events/button_verify_interaction.dart';
import 'events/member_join_event.dart';

class VerificationModule extends MineralPackageContract {
  VerificationModule (): super('Antibot', 'Antibot description');
  
  @override
  Future<void> init () async {
    commands.register([
      SetupVerification(),
      Unlink(),
    ]);
    events.register([
      ButtonVerifyInteraction(),
      MemberJoin(),
      ButtonStaffConnexionInteraction(),
    ]);
    contextMenus.register([]);
    states.register([]);
  }
}