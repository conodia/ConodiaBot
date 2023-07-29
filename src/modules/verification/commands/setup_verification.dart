import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

class SetupVerification extends MineralCommand<GuildCommandInteraction> with  Container {
  SetupVerification(): super(label: Display('setupverification'), description: Display('Setup le message de vérification'), permissions: [ClientPermission.administrator]);

  Future<void> handle (GuildCommandInteraction interaction) async {
    final choiceEmbed = EmbedBuilder(
        title: "Vérification",
        description: "Veuillez cliquer sur le bouton ci-dessous pour vous vérifier, vous recevrez un code a entrer en jeu.\n\n`/link <code>`",
        color: Color.invisible);

    final verifyButton = ButtonBuilder.button("proccessVerifiy")
    ..setLabel("Vérification")
    ..setStyle(ButtonStyle.primary)
    ..setEmoji(EmojiBuilder.fromUnicode("🛡"));

    await interaction.channel?.send(embeds: [choiceEmbed], components: ComponentBuilder()..withButton.many([verifyButton]));
    await interaction.reply(content: "Le message de vérification est bien installé.", private: true);
  }
}