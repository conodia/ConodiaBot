import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';
import 'subcommands/addmember_subcommand.dart';
import 'subcommands/close_ticket_subcommand.dart';
import 'subcommands/removemember_subcommand.dart';

class TicketCommand extends MineralCommand<GuildCommandInteraction> with State, Container {
  TicketCommand(): super(label: Display("ticket"), description: Display("Les commandes utiles au ticket"), permissions: [ClientPermission.administrator], subcommands: [AddMemberSubCommand(), RemoveMemberSubCommand(), CloseTicketSubCommand()]);
}