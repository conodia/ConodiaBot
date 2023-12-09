import 'package:mineral/core.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/services.dart';
import 'package:mineral/framework.dart';

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
  await MessageService().init();

  Kernel kernel = Kernel(
      intents: IntentService(all: true),
      packages: PackageService([
        TicketModule(),
        InvitationsModule(),
        GiveawayModule(),
        VerificationModule(),
        GlobalModule(),
       ]),
    events: EventService([
      Ready(),
      ReadyWebsocket(),
      Test(),
    ]),
  );
  await kernel.init();
}

class Test extends MineralEvent<MessageCreateEvent> {
  Future<void> handle(event) async {
    print(event.message.content);
  }
}