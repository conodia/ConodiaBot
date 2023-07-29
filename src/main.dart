import 'package:mineral/core.dart';
import 'package:mineral/src/internal/services/intent_service.dart';

import 'events/ready.dart';
import 'messages/message_service.dart';
import 'modules/giveaways/giveaway_module.dart';
import 'modules/global/global_module.dart';
import 'modules/invitations/invitations_module.dart';
import 'modules/ticket/ticket_module.dart';
import 'modules/verification/verification_module.dart';
import 'websocket/ready_ws.dart';

void main() async  {

  /**
   * Init Mineral
   */
  MessageService().init();

  Kernel kernel = Kernel(intents: IntentService(all: true))
    ..commands.register([])
    ..events.register([
      Ready(),
      ReadyWebsocket(),
    ])
    ..packages.register([
      TicketModule(),
      InvitationsModule(),
      GiveawayModule(),
      VerificationModule(),
      GlobalModule(),
    ])
    ..contextMenus.register([])
    ..states.register([]);
  await kernel.init();
}


