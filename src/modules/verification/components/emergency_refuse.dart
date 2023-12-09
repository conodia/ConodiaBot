import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/src/internal/websockets/events/button_create_event.dart';

import '../../../managers/api/api_http_service.dart';

class EmergencyRefuseButton extends InteractiveButton with State, Container {
  EmergencyRefuseButton() : super('emergency_refuse', standalone: true);

  @override
  ButtonBuilder build() => ButtonBuilder(customId)
    ..setLabel("Refuser la mise en urgence")
    ..setStyle(ButtonStyle.primary)
    ..setEmoji(EmojiBuilder.fromUnicode("😱"));

  @override
  Future<void> handle(ButtonCreateEvent<PartialChannel> interaction) async {
    await container.use<PandaApiHttpService>().post(url: "/settings/set-emergency/false").build();

    await interaction.interaction.reply(content: "La mise en urgence a été refuse, pour l'activer faites /emergency !", private: false);
    await interaction.interaction.delete();
  }
}