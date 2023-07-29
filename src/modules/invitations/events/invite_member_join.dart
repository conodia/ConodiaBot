import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral_invite/mineral_invite.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';
import '../../../messages/extensions/invite_string_extension.dart';
import '../../../messages/extensions/string_extension.dart';

import '../../../mixins/panda_mixins.dart';
import '../../global/states/global_state.dart';
import '../managers/invite_manager.dart';
import 'package:mineral/src/api/invites/invite.dart';

class InviteMemberJoin extends MineralEvent<InviteMemberAdd> with State, PandaMixins, Container {
  Future<void> handle (event) async {
    Guild guild = event.joinEvent.member.guild;
    GuildMember member = event.joinEvent.member;
    final messageConfig = container.use<MessageEntity>();
    final globalConfig = states.use<GlobalState>().state;
    print(event.invite?.code);

    if(event.isVanity) {
      final embedWelcome = EmbedBuilder(
          title: messageConfig.global.welcome.vanity.title.reMember(member).reGuild(guild).reMembersCount(guild).reVanity(guild),
          description: messageConfig.global.welcome.vanity.description.reMember(member).reGuild(guild).reMembersCount(guild).reVanity(guild),
          footer: EmbedFooter(text: messageConfig.global.welcome.vanity.footer!.reMember(member).reGuild(guild).reMembersCount(guild).reVanity(guild)),
          color: Color.invisible
      );

      TextBasedChannel welcomeChannel = guild.channels.cache.getOrFail(globalConfig.welcomeChannel) as TextBasedChannel;
      await welcomeChannel.send(embeds: [embedWelcome]);
      return;
    }

    GuildMember? inviter = await event.invite?.getInviter()?.toMember();
    InviteManager? inviteManager = invitesCache.cache.get(inviter?.id);
    Invite? invite = event.invite;

    if(inviter == null || invite == null) {
      return;
    }

    if(inviteManager == null) {
      inviteManager = InviteManager(inviter, []);
      await inviteManager.create();
    }

    await inviteManager.addUser(event.joinEvent.member.user);

    final embedWelcome = EmbedBuilder(
        title: messageConfig.global.welcome.normal.title.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager).reCode(invite),
        description: messageConfig.global.welcome.normal.description.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager).reCode(invite),
        footer: EmbedFooter(text: messageConfig.global.welcome.normal.footer!.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager).reCode(invite)),
        color: Color.invisible
    );

    TextBasedChannel welcomeChannel = guild.channels.cache.getOrFail(globalConfig.welcomeChannel) as TextBasedChannel;
    await welcomeChannel.send(embeds: [embedWelcome]);
  }
}