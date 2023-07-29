import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart'; 
import 'package:mineral/framework.dart';

import '../../modules/giveaways/managers/giveaway_manager.dart';

extension GiveawayStringExtension on String {

  /*
  *
  * Giveaway
  *
  * */

  String reGiveaway(GiveawayManager giveaway) {
    TextChannel channel = giveaway.guild!.channels.cache.getOrFail(giveaway.channelId) as TextChannel;
    return this.replaceAll("{giveaway}", giveaway.name).replaceAll("{description}", giveaway.description).replaceAll("{lot}", giveaway.lot).replaceAll("{channel}", channel.toString()).replaceAll("{message}", giveaway.messageId).replaceAll("{duration}", "<t:${getDurationFromTimestamp(giveaway.timestampEnd)}:R>").replaceAll("{id}", giveaway.id).replaceAll("{winners.number}", giveaway.winnerCount.toString());
  }

  String reWinners(List<String> winners) {
    String winnersString = "";

    for(String winner in winners) {
      winnersString += "<@$winner>, ";
    }

    return this.replaceAll("{winners}", winnersString);
  }

  int getDuration(int days, int hours, int minutes) {
    final now = (DateTime.now().millisecondsSinceEpoch + DateTime.now().millisecond) /  1000;
    return now.round() + (days * 86400) + (hours * 3600) + (minutes * 60);
  }
  
  int getDurationFromTimestamp(int timestamp) {
    double diff = (timestamp / 1000);
    return diff.toInt();
  }
}