import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../global/states/global_state.dart';
import '../managers/verification_manager.dart';

class MemberJoin extends MineralEvent<MemberJoinEvent> with Container, State {
  Future<void> handle(event) async {
    VerificationManager verificationManager = VerificationManager(user: event.member.user);
    final globalState = states.use<GlobalState>().state;
    if (await verificationManager.isLink()) {
      await event.member.roles.add(globalState.verifiedRole);
    }
  }
}