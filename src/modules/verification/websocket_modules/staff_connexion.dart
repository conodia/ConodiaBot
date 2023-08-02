import 'dart:io';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../websocket/contracts/websocket_contract.dart';
import '../../../websocket/websocket_bot.dart';
import '../../global/states/global_state.dart';

class StaffConnexionModule extends WebSocketContract with Container, State, Client {
  @override
  Future<void> handle(WebSocket webSocket, Map<String, dynamic> data) async {
    final globalConfig = states.use<GlobalState>().state;
    Guild guild = client.guilds.cache.getOrFail(globalConfig.guildId);
    GuildMember member = await guild.members.resolve(data['data']['player']['discord_user_id']);

    final verifiedEmbed = EmbedBuilder(
      title: "Vérification",
      description: "Voulez vous vous connecter en tant que ${data['data']['player']['minecraft_playername']} ?\n\nIp: ||${data['data']['player']['ip']}||\nSi oui, cliquez sur le bouton ci-dessous.",
      color: Color.green_400,
    );

    final verifiedButton = ButtonBuilder("staff_connexion_accept")
    ..setLabel("Se connecter")
    ..setStyle(ButtonStyle.primary)
    ..setEmoji(EmojiBuilder.fromUnicode("🔑"));

    final refuseButton = ButtonBuilder("staff_connexion_refuse")
    ..setLabel("Refuser")
    ..setStyle(ButtonStyle.danger)
    ..setEmoji(EmojiBuilder.fromUnicode("❌"));

    await member.user.send(embeds: [verifiedEmbed], components: ComponentBuilder()..withButton.many([verifiedButton, refuseButton]));
  }

  @override
  WCode get type => WCode.STAFF_CONNEXION;
}
