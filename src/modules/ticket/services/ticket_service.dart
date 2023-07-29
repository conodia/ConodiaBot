import 'dart:io';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral_ioc/src/mineral_service.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../../../managers/config_manager.dart';
import '../../../panda/panda_constants.dart';
import '../states/ticket_state.dart';
import '../settings/ticket_settings.dart';
import 'type/ticket_type.dart';

class TicketService extends MineralService with Console, State {
  File settingsFile = File(join(Directory.current.path, "config", "ticket.yml"));

  TicketService() : super(inject: true) {
    init();
  }

  void init() async {
    if(!settingsFile.existsSync()) {
      settingsFile = await ConfigManager().downloadFile(PandaConstant.ticketUrl, "ticket.yml");
    }

    dynamic settings = loadYaml(settingsFile.readAsStringSync());

    final myState = states.use<TicketState>();
    var type;
    List<TicketType> typesList = [];
    for(type in settings['types']) {
      final List<Snowflake> listRoles = [];
      for(final id in type['roles']) {
        listRoles.add(id);
      }
      typesList.add(TicketType(type['id'], type['name'], type['description'], EmojiBuilder.fromUnicode(type['emoji']), type['categorie'], type['welcome_message'], listRoles));
    }

    myState.setTicket(TicketSettings(settings['logs_channel'], settings['close_categorie'] , typesList));
  }
}