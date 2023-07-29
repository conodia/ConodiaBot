import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';



class ButtonRulesInteraction extends MineralEvent<ButtonCreateEvent> with Container {
  Future<void> handle (event) async {
    if(!event.interaction.customId.equals("rulesButton")) return;
    final messages = container.use<MessageEntity>().global;

    final rulesEmbed = EmbedBuilder(
      title: messages.setup.rules.title,
      description: messages.setup.rules.description,
      color: Color.invisible
    );

    await event.interaction.reply(embeds: [rulesEmbed], private: true);
  }
}