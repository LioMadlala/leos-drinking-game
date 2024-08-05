import 'package:leos_drinking_game/models/user_model.dart';

abstract class BaseGame {
  String get name;
  String get type;
  int get numberOfPlayers;

  String getPrompt(List<UserModel> players);
}

class GameWithPrompt {
  final String name;
  final String type;
  final String prompt;
  final int numberOfPlayers;

  GameWithPrompt(
      {required this.name,
      required this.type,
      required this.prompt,
      required this.numberOfPlayers});
}
