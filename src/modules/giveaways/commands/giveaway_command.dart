import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import 'subcommands/create_giveaway.dart';
import 'subcommands/end_giveaway.dart';
import 'subcommands/list_giveaway.dart';
import 'subcommands/reroll_giveaway.dart';

class GiveawayCommand extends MineralCommand<GuildCommandInteraction> {
  GiveawayCommand(): super(label: Display("giveaway"), description: Display("Gérer les giveaway"), permissions: [ClientPermission.administrator], subcommands: [
    CreateGiveaway(),
    EndGiveaway(),
    ListGiveaway(),
    RerollGiveaway()
  ]);
}
