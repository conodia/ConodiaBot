import 'dart:io';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../websocket/contracts/websocket_contract.dart';
import '../../../websocket/websocket_bot.dart';
import '../../global/states/global_state.dart';
import '../components/emergency_accept.dart';
import '../components/emergency_refuse.dart';

class EmergencyModule extends WebSocketContract with Container, State, Client {
  @override
  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data) async {
    final globalConfig = states.use<GlobalState>().state;
    Guild guild = client.guilds.cache.getOrFail(globalConfig.guildId);
    GuildMember member = await guild.members.cache.getOrFail("670642326661496866");

    final verifiedEmbed = EmbedBuilder(
      title: "🚨 Ugence ! 🚨",
      description: "Une demande de mise en urgence a été demandée, souhaitez vous la mettre en application ?",
      color: Color.red_500,
    );

    await member.user.send(embeds: [verifiedEmbed], components: ComponentBuilder()..withButton.many([EmergencyAcceptButton().build(), EmergencyRefuseButton().build()]));
  }

  @override
  WCode get type => WCode.EMERGENCY_REQUEST;
}
