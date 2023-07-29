import 'package:mineral_ioc/ioc.dart';

import '../modules/giveaways/cache/giveaways_cache.dart';
import '../modules/invitations/cache/invite_cache.dart';
import '../modules/invitations/cache/users_settings.dart';
import '../modules/ticket/cache/ticket_cache.dart';

mixin PandaMixins {
  TicketCache get ticketsCache => ioc.use<TicketCache>();
  InvitePandaCache get invitesCache => ioc.use<InvitePandaCache>();
  UsersCache get usersCache => ioc.use<UsersCache>();
  GiveawayCache get giveawaysCache => ioc.use<GiveawayCache>();
}