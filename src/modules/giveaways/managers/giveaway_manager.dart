import 'dart:async';
import 'dart:math';
import 'package:http/http.dart';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../managers/api/api_http_service.dart';
import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/giveaway_string_extension.dart';
import '../../../messages/extensions/string_extension.dart';

import '../../../mixins/panda_mixins.dart';

class GiveawayManager with Container, State, PandaMixins {
  final String _name;
  final String _description;
  final String _lot;
  final int _timestampStart;
  final int _timestampEnd;
  final int _winnerCount;
  final String _channelId;
  String messageId;
  final String _id;
  final List<String> _users;
  bool isActive;
  final Guild? _guild;

  GiveawayManager(
      this._name,
      this._description,
      this._channelId,
      this._lot,
      this._timestampEnd,
      this._timestampStart,
      this._winnerCount,
      this._id,
      this._users,
      this._guild,
      {this.isActive = true,
      this.messageId = ""});

  // Getters
  String get name => _name;

  String get description => _description;

  String get lot => _lot;

  int get timestampStart => _timestampStart;

  int get timestampEnd => _timestampEnd;

  int get winnerCount => _winnerCount;

  String get channelId => _channelId;

  String get id => _id;

  List<String> get users => _users;

  Guild? get guild => _guild;

  int get endTime => _timestampEnd - DateTime.now().millisecondsSinceEpoch;

  Future<void> create(int daysDuration, int hoursDuration, int minutesDuration) async {
    giveawaysCache.cache.putIfAbsent(this._id, () => this);

    await container.use<PandaApiHttpService>().post(url: '/giveaways').payload(toJson).build();
    await this.start();
  }

  Future<void> delete() async {
    this.isActive = false;
    await container.use<PandaApiHttpService>().destroy(url: '/giveaways/$_id').build();
  }

  Future<int> addMember(GuildMember member) async {
    Response response = await container
        .use<PandaApiHttpService>()
        .post(url: '/giveaways/$_id/addmember')
        .payload({"memberId": member.id}).build();

    if (response.statusCode == 200) {
      this._users.add(member.id);
    }

    return response.statusCode;
  }

  Future<void> grantVictory() async {
    List<String> winners = [];
    TextChannel channel = _guild!.channels.cache.getOrFail(this._channelId);
    await channel.messages.sync();
    Message message = channel.messages.cache.getOrFail(this.messageId);
    final messages = container.use<MessageEntity>().giveaway;

    this.isActive = false;
    this.delete();

    if (this.users.length < this._winnerCount) {
      final gotoGiveawayButton = ButtonBuilder.link(
          "https://discord.com/channels/${guild!.id}/$channelId/$messageId")
        ..setLabel(messages.buttonGo);

      final endEmbed = EmbedBuilder(
          title: messages.noWinners.title.reGiveaway(this).reWinners(winners),
          description: messages.noWinners.description.reGiveaway(this),
          color: Color.invisible);

      final noWinnersEmbed = EmbedBuilder(
          title: messages.noWinners.title.reGiveaway(this),
          description: messages.noWinners.description.reGiveaway(this),
          color: Color.red_300);

      await message.edit(embeds: [endEmbed]);
      await channel.send(embeds: [
        noWinnersEmbed
      ], components: ComponentBuilder()..withButton.many([gotoGiveawayButton]));
      return;
    }

    for (int i = 0; i < this._winnerCount; i++) {
      int random = Random().nextInt(this.users.length);
      winners.add(this.users[random].replaceAll('"', ""));
      this.users.removeAt(random);
    }

    final winEmbed = EmbedBuilder(
        title: messages.victorySendUser.title.reGiveaway(this).reWinners(winners).reGuild(_guild!),
        description: messages.victorySendUser.description.reGiveaway(this).reWinners(winners).reGuild(_guild!),
        color: Color.invisible);

    for (String id in winners) {
      GuildMember member = await guild!.members.cache.getOrFail(id);
      await member.user.send(embeds: [winEmbed]);
    }

    final endEmbed = EmbedBuilder(
        title: messages.end.title.reGiveaway(this).reWinners(winners),
        description:
            messages.end.description.reGiveaway(this).reWinners(winners),
        color: Color.invisible);

    final gotoGiveawayButton = ButtonBuilder.link(
        "https://discord.com/channels/${guild!.id}/$channelId/$messageId")
      ..setLabel(messages.buttonGo);

    final embedWin = EmbedBuilder(
        title: messages.end.title.reGiveaway(this).reWinners(winners),
        description:
            messages.end.description.reGiveaway(this).reWinners(winners),
        color: Color.orange_500);

    await message.edit(embeds: [endEmbed]);
    await channel.send(
        embeds: [embedWin],
        components: ComponentBuilder()..withButton.many([gotoGiveawayButton]));
  }

  Future<void> start() async {
    if (!this.isActive) return;
    if (this.timestampEnd <= DateTime.now().millisecondsSinceEpoch) {
      await this.grantVictory();
    } else {
      Timer(Duration(milliseconds: this.timestampEnd - DateTime.now().millisecondsSinceEpoch), () async {
        if (this.isActive) {
          await this.grantVictory();
        }
      });
    }
  }

  void setMessageId(String messageId) {
    this.messageId = messageId;
  }

  Map<String, dynamic> get toJson => {
    "id": this._id,
    "name": this._name,
    "description": this._description,
    "lot": this._lot,
    "timestampStart": this._timestampStart,
    "timestampEnd": this._timestampEnd,
    "maxWinner": this._winnerCount,
    "channelId": this._channelId,
    "messageId": this.messageId,
    "isActive": this.isActive,
    "buttonId": this._id
  };

  factory GiveawayManager.from(
      {required dynamic payload, required Guild guild}) {
    List<String> users = [];

    // payload['members'] is a String, transform it to List<String>

    if (payload['members'] != null) {
      users = payload['members']
          .toString()
          .replaceAll('[', "")
          .replaceAll(']', "")
          .replaceAll('{', "")
          .replaceAll('}', "")
          .split(',');
    }

    GiveawayManager giveawayManager = GiveawayManager(
        payload['name'],
        payload['description'],
        payload['channel_id'],
        payload['lot'],
        int.parse(payload['timestamp_end']),
        int.parse(payload['timestamp_start']),
        payload['max_winner'],
        payload['id'],
        users,
        guild,
        isActive: payload['is_active'],
        messageId: payload['message_id']);

    return giveawayManager;
  }
}
