import 'dart:convert';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../managers/api/api_http_service.dart';
import '../../../managers/cache_manager.dart';
import 'package:http/http.dart';

import '../manager/ticket_manager.dart';

class TicketCache extends CacheManager<TicketManager> with Container {

  Future<void> sync(Guild guild) async {
    this.cache.clear();
    Response response = await container.use<PandaApiHttpService>().get(url: '/tickets').build();
    final payload = jsonDecode(response.body);

    for(dynamic ticket in payload['tickets']) {
      TextBasedChannel? channel = guild.channels.cache.get(ticket['id']);
      GuildMember? member = guild.members.cache.get(ticket['user_id']);

      if(channel == null) {
        await container.use<PandaApiHttpService>().destroy(url: '/tickets/${ticket['id']}').build();
        return null;
      }

      if(member == null) {
        await container.use<PandaApiHttpService>().destroy(url: '/tickets/${ticket['id']}').build();
        await channel.send(content: "Le membre ayant ouvert ce ticket n'est plus sur le serveur. Vous pouvez supprimer ce ticket. @everyone");
        return null;
      }

      await channel.messages.sync();

      TicketManager ticketManager = TicketManager.from(payload: ticket, guild: guild, channel: channel, member: member);
      this.cache.putIfAbsent(ticketManager.channel.id, () => ticketManager);
    }
  }

  /*Future<TicketManager?> resolve(Snowflake channelId, Guild guild) async {
    if(this.cache.containsKey(channelId)) {
      return this.cache.getOrFail(channelId) as Future<TicketManager>;
    }

    Response response = await container.use<PandaApiHttpService>().get(url: '/tickets/${channelId}').build();
    final payload = jsonDecode(response.body);
    TextBasedChannel? channel = guild.channels.cache.get(payload['id']);
    GuildMember? member = guild.members.cache.get(payload['user_id']);

    if(channel == null) {
      await container.use<PandaApiHttpService>().destroy(url: '/tickets/${payload['id']}').build();
      return null;
    }

    if(member == null) {
      await container.use<PandaApiHttpService>().destroy(url: '/tickets/${payload['id']}').build();
      await channel.send(content: "Le membre ayant ouvert ce ticket n'est plus sur le serveur. Vous pouvez supprimer ce ticket. @everyone");
      return null;
    }

    await channel.messages.sync();

    TicketManager ticketManager = TicketManager.from(payload: payload, guild: guild, channel: channel, member: member);
    this.cache.putIfAbsent(ticketManager.channel.id, () => ticketManager);
    return ticketManager;
  }*/
}
