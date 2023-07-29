import 'package:mineral/core/api.dart';
import '../../modules/global/entities/select_roles_entities.dart';

extension StringExtension on String {

  /*
  *
  *  Global
  *
  *
  *  */

  String reUser(User user) {
    return this.replaceAll("{user}", user.tag);
  }

  String reReason(String reason) {
    return this.replaceAll("{reason}", reason);
  }

  String reTime(String time) {
    return this.replaceAll("{time}", time);
  }

  String reModerator(User moderator) {
    return this.replaceAll("{moderator}", moderator.tag);
  }

  String reChannel(TextChannel channel) {
    return this.replaceAll("{channel}", channel.toString());
  }

  String reModeration(User user, String? reason, User moderator, Guild guild) {
    if(reason!.isEmpty) reason = "Aucune raison";
    return this.replaceAll("{user}", user.tag).replaceAll("{reason}", reason).replaceAll("{moderator}", moderator.tag).replaceAll("{guild}", guild.name);
  }

  String reRoles(List<SelectRoles> roles) {
    String rolesString = "";

    for(SelectRoles role in roles) {
      rolesString += "${role.label}, ";
    }

    return this.replaceAll("{roles}", rolesString);
  }

  String reSuggestion(String suggestion) {
    return this.replaceAll("{suggestion}", suggestion);
  }
  String reMembersCount(Guild guild) {
    return this.replaceAll("{members}", guild.members.cache.length.toString());
  }
}