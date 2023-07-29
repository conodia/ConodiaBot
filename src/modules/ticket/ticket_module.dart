import 'package:mineral/core/extras.dart'; 
import 'package:mineral/framework.dart';
import 'package:mineral_contract/mineral_contract.dart';

import 'commands/ticket_command.dart';
import 'commands/ticket_create.dart';
import 'events/button_interaction.dart';
import 'events/menu_interaction.dart';
import 'events/ready_tickets.dart';
import 'services/ticket_service.dart';
import 'states/ticket_state.dart';

class TicketModule extends MineralPackageContract {
  TicketModule (): super('Ticket', 'Module de tickets');
  
  @override
  Future<void> init () async {
    commands.register([
      TicketCreate(),
      TicketCommand(),
    ]);
    events.register([
      MenuInteraction(),
      ButtonInteraction(),
      ReadyTickets(),
    ]);
    contextMenus.register([]);
    states.register([
      TicketState(),
    ]);
    TicketService();
  }
}