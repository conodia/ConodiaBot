import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../messages/entities/message_entity.dart';
import '../../../../mixins/panda_mixins.dart';
import '../../managers/giveaway_manager.dart';

class EndGiveaway extends MineralSubcommand<GuildCommandInteraction> with State, Container, PandaMixins {
  EndGiveaway(): super(label: Display("end"), description: Display("Terminer un giveaway"), options: [
    CommandOption.string(Display("id"), Display("L'id du giveaway"), required: true)
  ]);

  Future<void> handle (CommandInteraction interaction) async {
    final id = interaction.getValue<String>("id");
    final messages = container.use<MessageEntity>().giveaway;
    GiveawayManager? giveaway = giveawaysCache.cache.get(id);

    if (giveaway == null) {
      final errorEmbed = EmbedBuilder(
          title: messages.notExist.title,
          description:messages.notExist.description,
          color: Color.red_500);

      await interaction.reply(embeds: [errorEmbed], private: true);
      return;
    } else {
     await giveaway.delete();

      final successEmbed = EmbedBuilder(
          title: "Le giveaway a été terminé !",
          description: "Le giveaway a été terminé avec succès !",
          color: Color.green_400);

      await interaction.reply(embeds: [successEmbed], private: true);
    }
  }
}