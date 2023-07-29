import 'dart:async';
import 'dart:convert';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import '../../../managers/api/api_http_service.dart';
import '../../../managers/cache_manager.dart';
import 'package:http/http.dart';

import '../managers/giveaway_manager.dart';

class GiveawayCache extends CacheManager<GiveawayManager> with Container {
  Future<void> sync(Guild guild) async {
    this.cache.clear();
    Response response = await container
        .use<PandaApiHttpService>()
        .get(url: '/giveaways/')
        .build();
    dynamic payload = jsonDecode(response.body);

    for (dynamic giveaway in payload["giveaways"]) {
      GiveawayManager giveawayManager = GiveawayManager.from(payload: giveaway, guild: guild);
      this.cache.putIfAbsent(giveawayManager.id, () => giveawayManager);
      giveawayManager.start();
    }
  }
}
