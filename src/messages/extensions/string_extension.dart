import 'package:mineral/core/api.dart';


extension StringExtension on String {

  String reGuild(Guild guild) {
    return this.replaceAll("{guild}", guild.name);
  }

  String reMember(GuildMember member) {
    return this.replaceAll("{username}", member.user.username).replaceAll("{tag}", member.user.isMigrated ? member.user.globalName! : member.user.tag).replaceAll("{user}", member.user.username);
  }
}