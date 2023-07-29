import 'messages/antibot_entity_message.dart';
import 'messages/giveaway_entity_message.dart';
import 'messages/global_entity_message.dart';
import 'messages/invite_entity_message.dart';
import 'messages/tickets_entity_message.dart';
import 'package:mineral_ioc/src/mineral_service.dart';

class MessageEntity extends MineralService {
    final GiveawayEntityMessage giveaway;
    final AntiBotEntityMessage antibot;
    final GlobalEntityMessage global;
    final TicketEntityMessage ticket;
    final InviteEntityMessage invites;

    MessageEntity({
        required GiveawayEntityMessage this.giveaway,
        required AntiBotEntityMessage this.antibot,
        required GlobalEntityMessage this.global,
        required TicketEntityMessage this.ticket,
        required InviteEntityMessage this.invites,
    });
}