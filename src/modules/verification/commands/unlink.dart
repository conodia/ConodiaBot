import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../managers/verification_manager.dart';

class Unlink extends MineralCommand<GuildCommandInteraction> with  Container {
  Unlink(): super(label: Display('unlink'), description: Display('Unlink un membre'), permissions: [ClientPermission.administrator], options: [
    CommandOption.user(Display('membre'), Display('Unlink le membre séléctionné'), required: true)
  ]);

  Future<void> handle (GuildCommandInteraction interaction) async {
    final member = interaction.getMember("membre")!;

    VerificationManager verificationManager = VerificationManager(user: member.user);

    if (!await verificationManager.isLink()) {
      await interaction.reply(content: "Ce compte n'est pas link !", private: true);
      return;
    }

    await verificationManager.unlink();

    final embed = EmbedBuilder(
      title: "Unlink",
      description: "Vous avez été unlink de votre compte Discord -> Minecraft !",
      color: Color.red_500
    );

    await member.user.send(embeds: [embed]);
    await interaction.reply(content: "Vous avez bien unlink $member !", private: true);
  }
}