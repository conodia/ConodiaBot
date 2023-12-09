import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/src/internal/websockets/events/button_create_event.dart';

import '../../../managers/api/api_http_service.dart';

class EmergencyAcceptButton extends InteractiveButton with State, Container {
  EmergencyAcceptButton() : super('emergency_accept', standalone: true);

  @override
  ButtonBuilder build() => ButtonBuilder(customId)
    ..setLabel("Accepter la mise en urgence")
    ..setStyle(ButtonStyle.danger)
    ..setEmoji(EmojiBuilder.fromUnicode("🚨"));

  @override
  Future<void> handle(ButtonCreateEvent<PartialChannel> interaction) async {
    await container.use<PandaApiHttpService>().post(url: "/settings/set-emergency/true").build();

    await interaction.interaction.reply(content: "La mise en urgence a été acceptée, pour désactiver la mise en urgence faites /emergency !", private: false);
    await interaction.interaction.delete();
  }
}