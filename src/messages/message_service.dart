import 'dart:io';

import 'package:mineral/core/extras.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../panda/panda_constants.dart';
import '../managers/config_manager.dart';
import 'entities/message_entity.dart';
import 'entities/messages/antibot_entity_message.dart';
import 'entities/messages/giveaway_entity_message.dart';
import 'entities/messages/global_entity_message.dart';
import 'entities/messages/invite_entity_message.dart';
import 'entities/messages/tickets_entity_message.dart';

class MessageService with Console, State, Container {
  Future<void> init() async {
    dynamic giveaway = await get(File(join(Directory.current.path, "config", "messages", "giveaway.yml")), "giveaway.yml");
    dynamic antibot = await get(File(join(Directory.current.path, "config", "messages", "antibot.yml")), "antibot.yml");
    dynamic global = await get(File(join(Directory.current.path, "config", "messages", "global.yml")), "global.yml");
    dynamic ticket = await get(File(join(Directory.current.path, "config", "messages", "ticket.yml")), "ticket.yml");
    dynamic invite = await get(File(join(Directory.current.path, "config", "messages", "invite.yml")), "invite.yml");

    GiveawayEntityMessage giveawayEntityMessage = GiveawayEntityMessage.from(payload: giveaway);
    AntiBotEntityMessage antiBotEntityMessage = AntiBotEntityMessage.from(payload: antibot);
    GlobalEntityMessage globalEntityMessage = GlobalEntityMessage.from(payload: global);
    TicketEntityMessage ticketEntityMessage = TicketEntityMessage.from(payload: ticket);
    InviteEntityMessage inviteEntityMessage = InviteEntityMessage.from(payload: invite);

    MessageEntity messageEntity = MessageEntity(
        giveaway: giveawayEntityMessage,
        antibot: antiBotEntityMessage,
        global: globalEntityMessage,
        ticket: ticketEntityMessage,
        invites: inviteEntityMessage,
    );

    container.bind((_) => messageEntity);
  }

  Future<dynamic> get(File file, String name) async {
    if(!file.existsSync()) {
      file = await ConfigManager().downloadFile(PandaConstant.baseMessageUrl + name, file.path);
    }

    return loadYaml(file.readAsStringSync());
  }
}
