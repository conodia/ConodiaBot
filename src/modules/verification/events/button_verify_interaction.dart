import 'dart:math';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../entities/verification.dart';
import '../managers/verification_manager.dart';

class ButtonVerifyInteraction extends MineralEvent<ButtonCreateEvent> with Container {
  Future<void> handle(event) async {
    if (!event.interaction.customId.equals("proccessVerifiy")) return;
    VerificationManager verificationManager = VerificationManager(user: event.interaction.user);
    bool isLink = await verificationManager.isLink();

    if (isLink) {
      final alreadyVerifiedEmbed = EmbedBuilder(
          title: "Déjà vérifié",
          description: "Vous êtes déjà vérifié !",
          color: Color.invisible);

      await event.interaction.reply(embeds: [alreadyVerifiedEmbed], private: true);
      return;
    }

    Verification verification = await verificationManager.verifyUser();

    final embedSendLink = EmbedBuilder(
        title: "Vérification",
        description: "Votre code: `${verification.code}`\n\n Veuillez entrer ce code en jeu pour vous vérifier: `/link ${verification.code}`",
        color: Color.invisible
    );

    await event.interaction.reply(embeds: [embedSendLink], private: true);
  }
}

String generateRandomString(int length) {
  var r = Random();
  const _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(length, (index) => _chars[r.nextInt(_chars.length)])
      .join();
}
