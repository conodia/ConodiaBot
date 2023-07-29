import 'dart:async';

import 'package:mineral/core/builders.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';

import '../../../../mixins/panda_mixins.dart';

class ListGiveaway extends MineralSubcommand<GuildCommandInteraction> with PandaMixins {
  ListGiveaway(): super(label: Display("list"), description: Display("Voir tout les giveaway en cours"));

  Future<void> handle(CommandInteraction interaction) async {
    if (giveawaysCache.cache.length == 0) {
      final errorEmbed = EmbedBuilder(
          title: "Il n'y a pas de giveaways en cours !", color: Color.red_500);
      await interaction.reply(embeds: [errorEmbed], private: true);
      return;
    }

    final embed = EmbedBuilder(
        title: "Voici les giveaways en cours",
        description:
            "${giveawaysCache.cache.values.map((e) => e.id + " (${e.name})").join(", \n")}",
        color: Color.invisible);

    await interaction.reply(embeds: [embed], private: true);
  }
}
