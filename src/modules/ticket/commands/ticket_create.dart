import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart'; 
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';
import '../utils/ticket_utils.dart';

class TicketCreate extends MineralCommand<GuildCommandInteraction>  with State, Console {
  TicketCreate(): super(label: Display("ticketsetup"), description: Display("Setup le message pour les tickets"), permissions: [ClientPermission.administrator]);
  
  Future<void> handle (GuildCommandInteraction interaction) async {
    final embed = TicketUtils().embed();
    final selectMenu = TicketUtils().selectMenu();

    await interaction.channel?.send(embeds: [embed], components: ComponentBuilder()..withSelectMenu(selectMenu));
    await interaction.reply(content: "Vous avez bien envoyé l'embed pour le `Ticket` !", private: true);
  }
}