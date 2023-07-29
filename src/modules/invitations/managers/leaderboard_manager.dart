import 'dart:math';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/invite_string_extension.dart';
import '../../../messages/extensions/string_extension.dart';
import 'invite_manager.dart';

class LeaderboardManager with State, Container {
  final Map<String, InviteManager> invites;

  LeaderboardManager({required this.invites}) {
    this.invites.values.toList().sort((a, b) => b.actual.compareTo(a.actual));
  }

  String title = "Classement";

  EmbedBuilder first() {
    List<InviteManager> top = this.getTop(1);
    final messages = container.use<MessageEntity>().invites;

    final embed = EmbedBuilder(
      title: messages.leaderboard.message.title,
      description: messages.leaderboard.message.description.replaceAll("{leaderboard}", top.map((e) => messages.leaderboard.format.reLbUsers((top.indexOf(e)), e).reMember(e.inviter)).join("\n")),
      footer: EmbedFooter(text: messages.leaderboard.message.footer!.rePage(1, this.invites.values.toList())),
      color: Color.orange_500,
    );

    return embed;
  }

  EmbedBuilder getByIndex(int index) {
    if (index == 1) {
      return this.first();
    }

    List<InviteManager> top = this.getTop(index);
    final messages = container.use<MessageEntity>().invites;

    final embed = EmbedBuilder(
      title: messages.leaderboard.message.title,
      description: messages.leaderboard.message.description.replaceAll("{leaderboard}", top.map((e) => messages.leaderboard.format.reLbUsers((top.indexOf(e)) + (index * 10 - 10), e).reMember(e.inviter)).join("\n")),
      footer: EmbedFooter(text: messages.leaderboard.message.footer!.rePage(index, this.invites.values.toList())),
      color: Color.orange_500,
    );

    return embed;
  }

  List<InviteManager> getTop(int index) {
    this.invites.values.toList().sort((a, b) => b.actual.compareTo(a.actual));
    if (this.invites.length <= 10) {
      return this.invites.values.toList();
    }

    if (index == 1) {
      return this.invites.values.toList().sublist(0, 10);
    }

    int startIndex = (index - 1) * 10;
    int endIndex = min(startIndex + 10, invites.length);

    List<InviteManager> top = this.invites.values.toList().sublist(startIndex, endIndex);
    top.sort((a, b) => b.actual.compareTo(a.actual));

    return top;
  }

  ComponentBuilder getComponents(int index) {
    final previousButton = ButtonBuilder.button("previous:${index - 1}")
      ..setLabel("Précedent")
      ..setStyle(ButtonStyle.success);

    final homeButton = ButtonBuilder.button("home")
      ..setLabel("Page de départ")
      ..setStyle(ButtonStyle.primary);

    final nextButton = ButtonBuilder.button("next:${index + 1}")
      ..setLabel("Suivant")
      ..setStyle(ButtonStyle.success);

    if (invites.length < index * 10) {
      nextButton.setDisabled(true);
    }

    if (index <= 1) {
      previousButton.setDisabled(true);
    }

    return ComponentBuilder()
      ..withButton.many([previousButton, homeButton, nextButton]);
  }
}
