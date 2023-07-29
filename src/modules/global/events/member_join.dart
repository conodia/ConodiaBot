import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/extensions/global_string_extension.dart';
import '../../../messages/extensions/string_extension.dart';
import '../../../panda/panda_mixins.dart';
import '../states/global_state.dart';

class MemberJoin extends MineralEvent<MemberJoinEvent> with Container, State, PandaUtils {
  Future<void> handle (event) async {
    final settings = states.use<GlobalState>().state;
    TextBasedChannel channel = await event.guild.channels.resolve(settings.welcomeChannel) as TextBasedChannel;

    final embedWelcome = EmbedBuilder(
      title: messages.global.welcome.normal.title.reMember(event.member).reMembersCount(event.guild),
      description: messages.global.welcome.normal.description.reMember(event.member).reMembersCount(event.guild),
      color: Color.invisible
    );

    await event.member.roles.add(settings.verifiedRole);
    await channel.send(embeds: [embedWelcome]);
  }
}