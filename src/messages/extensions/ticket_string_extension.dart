import '../../modules/ticket/services/type/ticket_type.dart';

extension StringExtension on String {

  /*
  *
  *  Tickets
  *
  *
  *  */

  String reTypes(List<TicketType> types) {
    return this.replaceAll("{types}", types.map((e) => "${e.emoji.emoji.label} | ${e.name}").join("\n"));
  }
}