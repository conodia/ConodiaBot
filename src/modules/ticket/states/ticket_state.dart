import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';

import '../settings/ticket_settings.dart';
import '../services/type/ticket_type.dart';

class TicketState extends MineralState<TicketSettings> {
  TicketState(): super(TicketSettings("0", "", [TicketType("DefaultId", "DefaultName", "DefaultDescription", EmojiBuilder.fromUnicode("❓"), "none", "DefaultWelcomeMsg", ["DefaultId"])]));

  void setTicket (TicketSettings ticketSettings) => state = ticketSettings;
}