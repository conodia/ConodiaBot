import 'package:mineral_contract/mineral_contract.dart';

import 'commands/giveaway_command.dart';
import 'events/button_giveaway_interaction.dart';
import 'events/ready_giveaway.dart';

class GiveawayModule extends MineralPackageContract {
  GiveawayModule (): super('Giveaway', "Le module de Giveaway");
  
  @override
  Future<void> init () async {
    commands.register([
      GiveawayCommand(),
    ]);
    events.register([
      ReadyGiveaway(),
      ButtonGiveawayInteraction(),
    ]);
    contextMenus.register([]);
    states.register([]);
  }
}