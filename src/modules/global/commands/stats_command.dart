import 'dart:convert';

import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../managers/api/api_http_service.dart';
import 'package:http/http.dart';

import '../entities/jobs_entities.dart';


class StatsCommand extends MineralCommand with Container {
  StatsCommand(): super(label: Display('stats'), description: Display("Voir les statistiques d'un membre"), options: [
    CommandOption.user(Display('membre'), Display('Voir les stats du membre séléctionné'), required: false),
  ]);

  Future<void> handle(CommandInteraction interaction) async {
    GuildMember member = interaction.getMember('membre') ?? interaction.member!;

    Response response = await container.use<PandaApiHttpService>().get(url: "/jobs/${member.user.id}").build();
    JobsEntity jobs = JobsEntity.from(jsonDecode(response.body)['job']);

    EmbedBuilder embed = EmbedBuilder(
      title: "Statistiques de ${member.user.globalName}",
      description: ":warning: **Attention, les statistiques sont mis a jours après un levelup ou après une déconnexion en jeu, ce ne sont peut être pas les vraies statistiques du joueur !**\n\nVoici les statistiques de jobs de ${member.user.globalName}:\n\n- Mineur: ${jobs.miner.level} levels (${jobs.miner.xp} xp)\n- Bucheron: ${jobs.woodcutter.level} levels (${jobs.woodcutter.xp} xp)\n- Constructeur: ${jobs.constructor.level} levels (${jobs.constructor.xp} xp)\n- Chasseur: ${jobs.hunter.level} levels (${jobs.hunter.xp} xp)\n- Fermier: ${jobs.farmer.level} levels (${jobs.farmer.xp} xp)",
      color: Color.invisible,
    );

    await interaction.reply(embeds: [embed], private: true);
  }
}
