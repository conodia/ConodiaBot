import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../managers/api/api_http_service.dart';
import '../../global/states/global_state.dart';

class ButtonStaffConnexionInteraction extends MineralEvent<ButtonCreateEvent> with Container, Client, State {
  Future<void> handle(event) async {
    if (!event.interaction.customId.startsWith("staff_connexion")) return;

    final globalConfig = states.use<GlobalState>().state;
    Guild guild = client.guilds.cache.getOrFail(globalConfig.guildId);
    GuildMember member = await guild.members.resolve(event.interaction.user.id);

    if(event.interaction.customId == "staff_connexion_refuse") {
      await container.use<PandaApiHttpService>().destroy(url: "/staffconnexion/${member.id}/refuse").build();

      final refuseButton = ButtonBuilder("none")
      ..setLabel("Connexion Refusée")
      ..setStyle(ButtonStyle.danger)
      ..setDisabled(true);

      DmMessage message = event.interaction.message as DmMessage;
      await message.edit(embeds: [message.embeds[0]..setColor(Color.red_500)], components: ComponentBuilder()..withButton.only(refuseButton));

      await event.interaction.reply(content: "Vous avez refusé la connexion !", private: true);
      return;
    } else {
      await container.use<PandaApiHttpService>().destroy(url: "/staffconnexion/${member.id}").build();
      final acceptButton = ButtonBuilder("none")
        ..setLabel("Connexion Acceptée")
        ..setStyle(ButtonStyle.success)
        ..setDisabled(true);

      DmMessage message = event.interaction.message as DmMessage;
      await message.edit(embeds: [message.embeds[0]..setColor(Color.invisible)], components: ComponentBuilder()..withButton.only(acceptButton));
      await event.interaction.reply(content: "Vous avez accepté la connexion !", private: true);
    }
  }
}

