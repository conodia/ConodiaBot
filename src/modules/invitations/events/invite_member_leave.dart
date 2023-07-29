import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../messages/entities/message_entity.dart';
import '../../../messages/extensions/global_string_extension.dart';
import '../../../messages/extensions/invite_string_extension.dart';
import '../../../messages/extensions/string_extension.dart';

import '../../../mixins/panda_mixins.dart';
import '../../global/states/global_state.dart';
import '../managers/invite_manager.dart';

class InviteMemberLeave extends MineralEvent<MemberLeaveEvent> with State, Container, PandaMixins {
  Future<void> handle (event) async {
    GuildMember member = event.member;
    Guild guild = member.guild;
    String? inviterId = usersCache.cache.get(member.id);
    final settings = states.use<GlobalState>().state;
    final messages = container.use<MessageEntity>();

    if(inviterId == null) {
      return print('Inviter not found for ${member.user.tag} (code 1)');
    }

    InviteManager? inviteManager = invitesCache.cache.get(inviterId);
    GuildMember? inviter = event.member.guild.members.cache.get(inviterId);

    if(inviter == null) {
      return print('Inviter not found for ${member.user.tag} (code 2)');
    }

    if(inviteManager == null) {
      inviteManager = InviteManager(inviter, []);
      await inviteManager.create();
    }

    await inviteManager.removeUser(event.member.user);

    final leaveEmbed = EmbedBuilder(
        title: messages.global.leave.title.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager),
        description: messages.global.leave.description.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager),
        footer: EmbedFooter(text: messages.global.leave.footer!.reMember(member).reGuild(guild).reMembersCount(guild).reInvite(inviteManager)),
        color: Color.invisible
    );

    TextBasedChannel leaveChannel = guild.channels.cache.getOrFail(settings.leaveChannel) as TextBasedChannel;
    await leaveChannel.send(embeds: [leaveEmbed]);
  }
}