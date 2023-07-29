import 'dart:async';

import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import '../../../../../messages/entities/message_entity.dart';
import '../../../../../messages/extensions/global_string_extension.dart';
import '../../../../../mixins/panda_mixins.dart';
import '../../../managers/invite_manager.dart';

class SetInvitation extends MineralSubcommand<GuildCommandInteraction> with State, Container, PandaMixins {
  SetInvitation(): super(label: Display("set"), description: Display("Définir des invitations"), options: [
    CommandOption.user(Display("membre"), Display("Le member a ajouter des invitations"), required: true),
    CommandOption.integer(Display("actuelles"), Display("Les invitations actuelles + le nombre entré")),
    CommandOption.integer(Display("leaves"), Display("Les invitations leaves + le nombre entré")),
    CommandOption.integer(Display("bonus"), Display("Les invitations bonus + le nombre entré"))
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    User user = interaction.getMember("membre")!.user;


    InviteManager? inviteManager = invitesCache.cache.get(user.id);
    final messages = container.use<MessageEntity>().invites;

    if (inviteManager == null) {
      final errorEmbed = EmbedBuilder(
          title: messages.error.title.reUser(user),
          description: messages.error.description.reUser(user),
          color: Color.invisible);
      await interaction.reply(embeds: [errorEmbed], private: true);
      return;
    }

    int actual = interaction.getValue<int>("actuelles", defaultValue: inviteManager.actual);
    int leaves = interaction.getValue<int>("leaves", defaultValue: inviteManager.leaves);
    int bonus = interaction.getValue<int>("bonus", defaultValue: inviteManager.bonus);

    await inviteManager.edit(
        actuals: actual,
        leaves: leaves,
        bonus:  bonus
    );

    final embed = EmbedBuilder(
        title: "Succès !",
        description: "J'ai bien modifié les invitations de $user, avec ${inviteManager.actual} actuelles (${inviteManager.total} au total, ${inviteManager.leaves} parties, ${inviteManager.bonus} bonus) !",
        color: Color.invisible
    );

    await interaction.reply(embeds: [embed], private: true);
  }
}
