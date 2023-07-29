import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';

import '../../../managers/api/api_http_service.dart';
import '../../../mixins/panda_mixins.dart';
import '../services/type/ticket_type.dart';
import '../utils/ticket_utils.dart';

class TicketManager with Container, PandaMixins {
  final TextBasedChannel _channel;
  final TicketType _type;
  final GuildMember _openUser;

  TicketManager(this._channel, this._type, this._openUser);

  // Getters
  TextBasedChannel get channel => _channel;
  TicketType get type => _type;
  GuildMember get openUser => _openUser;

  Future<TicketManager> create() async {
    await container.use<PandaApiHttpService>().post(url: '/tickets/')
        .payload({
              "id": this.channel.id,
              "type": this.type.id,
              "userId": this.openUser.id,
              "firstMessageId": "ntt"
        })
        .build();

    ticketsCache.cache.putIfAbsent(_channel.id, () => this);
    return this;
  }

  Future<void> delete() async {
    try {
      await container
          .use<PandaApiHttpService>()
          .destroy(url: '/tickets/${_channel.id}')
          .build();

      ticketsCache.cache.remove(_channel.id);
    } catch (error) {}
  }

  factory TicketManager.from({ required dynamic payload,  required Guild guild, required GuildMember member, required TextBasedChannel channel }) {
    return TicketManager(channel, TicketUtils().getTicketType(payload['type']), member);
  }
}
