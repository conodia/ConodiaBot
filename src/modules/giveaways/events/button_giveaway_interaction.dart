import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';

import '../../../mixins/panda_mixins.dart';
import '../managers/giveaway_manager.dart';

class ButtonGiveawayInteraction extends MineralEvent<ButtonCreateEvent> with PandaMixins {
  Future<void> handle(event) async {
    if (!event.interaction.customId.startsWith("giveaway_")) return;
    GiveawayManager? giveaway = giveawaysCache.cache.get(event.interaction.customId);

    if (giveaway == null || !giveaway.isActive) {
      final finishEmbed = EmbedBuilder(
          title: "Ce giveaway est fini ou annulé !",
          description:
              "Nous sommes désolé du désagrément, mais ce giveaway est fini ou annulé.",
          color: Color.red_500);

      await event.interaction.reply(embeds: [finishEmbed], private: true);
      return;
    }

    int status = await giveaway.addMember(event.sender!);

    if (status == 305) {
      final alreadyEmbed = EmbedBuilder(
          title: "Vous participez déjà à ce giveaway !",
          description:
              "Vous ne pouvez pas participer deux fois au même giveaway.",
          color: Color.red_500);

      await event.interaction.reply(embeds: [alreadyEmbed], private: true);
      return;
    }

    final addedEmbed = EmbedBuilder(
        title: "Vous avez été ajouté à ce giveaway !", color: Color.green_400);

    if (event.interaction.message is Message) {
      Message message = event.interaction.message! as Message;

      final fields =
          event.interaction.message!.embeds[0].description!.split("\n");

      for (var i = 0; i < fields.length; i++) {
        if (fields[i].startsWith("Participants:")) {
          fields[i] = "Participants: ${giveaway.users.length}";
        }
      }

      final editEmbed = EmbedBuilder(
          title: event.interaction.message!.embeds[0].title,
          description: fields.join("\n"),
          color: Color.invisible);

      final editButton = ButtonBuilder.button(giveaway.id)
        ..setStyle(ButtonStyle.primary)
        ..setLabel("Participer")
        ..setEmoji(EmojiBuilder.fromUnicode("🎉"));

      await message.edit(
          embeds: [editEmbed],
          components: ComponentBuilder()..withButton.many([editButton]));

      await event.interaction.reply(embeds: [addedEmbed], private: true);
    }
  }
}
