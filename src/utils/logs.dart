import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../modules/ticket/states/ticket_state.dart';

class Logs with State {
   Future<void> send(LogsType type, String message, Guild? guild, AttachmentBuilder? attachment) async {
      final ticketState = states.use<TicketState>().state;
      TextBasedChannel? channel = guild!.channels.cache.getOrFail(ticketState.logs);

      EmbedBuilder logsEmbed = EmbedBuilder(
         title: "Logs " + type.value,
         description: message,
         color: type.color
      );

      if(attachment != null) {
         await channel.send(embeds: [logsEmbed], attachments: [attachment]);
      } else {
         await channel.send(embeds: [logsEmbed]);
      }
   }
}

enum LogsType {
   ticket("ticket", Color('#4b5563')),
   chat('chat', Color('#ea580c')),
   regular("autre", Color('#2f3136'));

   final String value;
   final Color color;
   const LogsType(this.value, this.color);
}