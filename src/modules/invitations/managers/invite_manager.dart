import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import '../../../managers/api/api_http_service.dart';
import '../../../mixins/panda_mixins.dart';

class InviteManager with Container, State, PandaMixins {
  final GuildMember inviter;
  final List<User> invitedUsers;
  int total;
  int actual;
  int leaves;
  int bonus;

  InviteManager(this.inviter, this.invitedUsers,  {this.total = 0, this.actual = 0, this.leaves = 0, this.bonus = 0});

  Future<void> create() async {
    await container.use<PandaApiHttpService>().post(url: "/invites").payload(toJson).build();
   invitesCache.cache.putIfAbsent(this.inviter.id, () => this);
  }

  Future<void> addUser(User user) async {
    await container.use<PandaApiHttpService>().post(url: "/invites/${inviter.id}/addinvite")
        .payload({
           "userId": user.id,
         }).build();

    usersCache.cache.putIfAbsent(user.id, () => this.inviter.id);
    this.invitedUsers.add(user);
    this.actual += 1;
    this.total += 1;
  }

  Future<void> removeUser(User user) async {
    await container.use<PandaApiHttpService>().destroy(url: "/invites/${inviter.id}/removeinvite/${user.id}").build();

    usersCache.cache.remove(user.id);
    this.invitedUsers.remove(user);
    this.actual -= 1;
    this.leaves += 1;
  }

  Future<void> edit({ required int actuals, required int leaves, required int bonus }) async {
    this.actual = actuals;
    this.leaves = leaves;
    this.bonus = bonus;
    this.total = actuals + leaves + bonus;

    await container
        .use<PandaApiHttpService>()
        .put(url: "/invites/${inviter.id}")
        .payload(toJson)
        .build();
  }

  dynamic get toJson => {
      "user_id": inviter.id,
      "actual": this.actual,
      "total": this.total,
      "bonus": this.bonus,
      "leaves": this.leaves
  };

  factory InviteManager.from({required dynamic payload, required Guild guild, required GuildMember inviter, required List<User> invitedUsers }) {
    return InviteManager(
      inviter,
      invitedUsers,
      actual: payload['actual'],
      bonus: payload['bonus'],
      leaves: payload['leaves'],
      total: payload['total']
    );
  }
}
