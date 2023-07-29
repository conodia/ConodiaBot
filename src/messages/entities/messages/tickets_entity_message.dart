import 'utils/embed_entity_message.dart';
import 'utils/ticket/close_message.dart';
import 'utils/ticket/member_message.dart';
import 'utils/ticket/ticket_message.dart';

class TicketEntityMessage {
  final MemberMessage member;
  final EmbedEntityMessage setup;
  final TicketMessage ticket;
  final CloseMessage close;

  final String notTicket;
  final String alreadyOpen;

  TicketEntityMessage(
      {required this.member,
      required this.setup,
      required this.ticket,
      required this.close,
      required this.notTicket,
      required this.alreadyOpen});

  factory TicketEntityMessage.from({required dynamic payload}) {
    return TicketEntityMessage(
        member: MemberMessage.from(payload: payload['member']),
        setup: EmbedEntityMessage.from(payload: payload['setup']),
        ticket: TicketMessage.from(payload: payload['ticket']),
        close: CloseMessage.from(payload: payload['close']),
        notTicket: payload['not_ticket'],
        alreadyOpen: payload['already_open']);
  }
}
