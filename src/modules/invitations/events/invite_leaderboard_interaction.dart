import 'package:mineral/core/api.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import '../../../mixins/panda_mixins.dart';
import '../managers/leaderboard_manager.dart';

class InviteLeaderboardInteraction extends MineralEvent<ButtonCreateEvent> with State, PandaMixins {
  Future<void> handle (event) async {
    String customId = event.interaction.customId;
    if(!customId.startsWith("next:") && !customId.startsWith("previous") && !customId.equals("home")) return;

    LeaderboardManager leaderboardManager = LeaderboardManager(invites: invitesCache.cache);
    Message message = event.interaction.message as Message;
    int index = 1;

    if(customId.startsWith("next:")) {
      index = int.parse(customId.replaceAll("next:", ""));
    } else if(customId.startsWith("previous:")) {
      index = int.parse(customId.replaceAll("previous:", ""));
    }

    await event.interaction.deferredReply();
    await event.interaction.delete();
    await message.edit(embeds: [leaderboardManager.getByIndex(index)], components: leaderboardManager.getComponents(index));
  }
}