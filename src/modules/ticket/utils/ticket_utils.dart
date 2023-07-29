import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/ticket_string_extension.dart';

import '../../../mixins/panda_mixins.dart';
import '../manager/ticket_manager.dart';
import '../services/type/ticket_type.dart';
import '../states/ticket_state.dart';

class TicketUtils with State, Container, PandaMixins {

  DynamicSelectMenuBuilder selectMenu() {
    final ticketState = states.use<TicketState>().state;
    final selectMenu = DynamicSelectMenuBuilder("ticket");

    for (TicketType type in ticketState.types) {
      selectMenu.addOption(
          label: type.name,
          description: type.description,
          value: type.id,
          emoji: type.emoji);
    }

    return selectMenu;
  }

  EmbedBuilder embed() {
    final ticketState = states.use<TicketState>().state;
    final messages = container.use<MessageEntity>().ticket;

    return EmbedBuilder(
        title: messages.setup.title.reTypes(ticketState.types),
        description: messages.setup.description.reTypes(ticketState.types),
        color: Color.invisible,
    );
  }

  bool isTicket(TextChannel channel) {
    return ticketsCache.cache.containsKey(channel.id);
  }

  bool isAlreadyOpen(GuildMember member) {
    bool isOpen = false;

    for(TicketManager ticket in ticketsCache.cache.values) {
      if(ticket.openUser.id == member.id) isOpen = true;
    }

    return isOpen;
  }

  TicketType getTicketType(String value) {
    final ticketConfig = states.use<TicketState>().state;
    TicketType? ticketType;
    for (TicketType type in ticketConfig.types) {
      if (type.id.equals(value)) ticketType = type;
    }

    return ticketType!;
  }

  TicketManager? getTicket(TextBasedChannel channel) {
    return ticketsCache.cache.get(channel.id);
  }
}
