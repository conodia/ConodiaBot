import 'dart:async';

import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../mixins/panda_mixins.dart';
import '../../managers/giveaway_manager.dart';

class RerollGiveaway extends MineralSubcommand<GuildCommandInteraction> with PandaMixins {
  RerollGiveaway(): super(label: Display("reroll"), description: Display("Reroll un giveaway"), options: [
    CommandOption.string(Display("id"), Display("L'id du giveaway"), required: true)
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    final id = interaction.getValue<String>("id");

    GiveawayManager? giveaway = giveawaysCache.cache.get(id);

    if (giveaway == null) {
      final errorEmbed = EmbedBuilder(
          title: "Ce giveaway n'existe pas !",
          description:
              "Nous sommes désolé du désagrément, mais ce giveaway n'existe pas.\n\nHors, il y a: ${giveawaysCache.cache.length} giveaways en cours:\n\n ${giveawaysCache.cache.values.map((e) => e.id + " (${e.name})").join(", \n")}",
          color: Color.red_500);
      await interaction.reply(embeds: [errorEmbed], private: true);
      return;
    } else {
      giveaway.grantVictory();

      final successEmbed = EmbedBuilder(
          title: "Le giveaway a été reroll !",
          description: "Le giveaway a été reroll avec succès !",
          color: Color.green_400);

      await interaction.reply(embeds: [successEmbed], private: true);
    }
  }
}
