import 'dart:io';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../websocket/contracts/websocket_contract.dart';
import '../../../websocket/websocket_bot.dart';
import '../../global/states/global_state.dart';

class VerifyUserModule extends WebSocketContract with Container, State, Client {
  @override
  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data) async {
    final globalConfig = states.use<GlobalState>().state;
    Guild guild = client.guilds.cache.getOrFail(globalConfig.guildId);
    GuildMember member = await guild.members.resolve(data['userId']);

    final verifiedEmbed = EmbedBuilder(
      title: "Vérification",
      description: "Vous êtes maintenant link avec votre compte minecraft: ${data['playername']} !",
      color: Color.green_400,
    );

    await member.user.send(embeds: [verifiedEmbed]);
    await member.roles.add(globalConfig.verifiedRole);
    await member.setUsername("${data['playername']}");
  }

  @override
  WCode get type => WCode.VERIFIED_USER;
}
