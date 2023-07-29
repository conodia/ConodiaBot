import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../messages/entities/message_entity.dart';
import '../../services/type/ticket_type.dart';
import '../../states/ticket_state.dart';

class CloseTicketSubCommand extends MineralSubcommand<GuildCommandInteraction> with State, Container {
  CloseTicketSubCommand(): super(label: Display("close"), description: Display("close_description"));
  
  Future<void> handle (CommandInteraction interaction) async {
    final ticketConfig = states.use<TicketState>().state;
    final messages = container.use<MessageEntity>().ticket;

    TextChannel channel = interaction.guild!.channels.cache.getOrFail(interaction.channel!.id);
    bool isTicket = false;

    for (TicketType type in ticketConfig.types) {
      if (channel.label.startsWith(type.emoji.emoji.label)) {
        isTicket = true;
      }
    }
    if (isTicket) {
      EmbedBuilder embedSure = EmbedBuilder(
          title: messages.close.verification.title,
          description: messages.close.verification.description,
          color: Color.invisible);

      final closeButton = ButtonBuilder.button("close")
        ..setStyle(ButtonStyle.danger)
        ..setLabel("Fermer");

      final cancelCloseButton = ButtonBuilder.button("cancelClose")
        ..setLabel("Annuler")
        ..setStyle(ButtonStyle.success);

      interaction.reply(embeds: [
        embedSure
      ], components: ComponentBuilder()..withButton.many([closeButton, cancelCloseButton]));
    } else {
      await interaction.reply(content: messages.notTicket, private: true);
    }
  }
}