import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';

class Errors {
  final Gravity _gravity;
  final String _message;
  Errors(
      Gravity this._gravity,
      String this._message
      );

    EmbedBuilder get embedBuilder => EmbedBuilder(
      title: this._gravity.title,
      description: this._message,
      color: this._gravity.color
    );
}

enum Gravity {
  big("ERREUR", Color('#991b1b')),
  middle("Erreur", Color('#ef4444')),
  regular("Petite erreur", Color('#fecaca')),
  no_permission("Pas la permission !", Color('#991b1b'));

  final String title;
  final Color color;
  const Gravity(this.title, this.color);
}