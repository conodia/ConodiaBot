import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../managers/api/api_http_service.dart';

class SetEmergency extends MineralCommand<GuildCommandInteraction> with  Container {
  SetEmergency(): super(label: Display('emergency'), description: Display("Mettre le serveur en mode urgence"),
      options: [
        CommandOption.bool(Display("enable"), Display("Activer la mise en urgence"), required: true),
        CommandOption.bool(Display("shutdown"), Display("Eteindre la machine completement"), required: false),

      ],
      permissions: [ClientPermission.administrator]
  );

  Future<void> handle (GuildCommandInteraction interaction) async {
    if (interaction.user.id != "670642326661496866") {
      await interaction.reply(content: "Vous n'avez pas la permission d'utiliser cette commande !", private: true);
      return;
    }

    bool enable = interaction.getValue<bool>("enable");
    bool shutdown = interaction.getValue<bool>("enable", defaultValue: false);

    await container.use<PandaApiHttpService>().post(url: "/settings/set-emergency/$enable/$shutdown").build();
    await interaction.reply(content: "La mise en urgence a été ${enable ? "activée" : "désactivée"} !", private: true);
  }
}