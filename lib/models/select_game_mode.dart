import 'package:leos_drinking_game/games/base_game.dart';

class GameMode {
  final String name;
  final String description;
  final String? image;
  final List<BaseGame> games;

  GameMode({
    required this.name,
    required this.description,
    this.image,
    required this.games,
  });
}
