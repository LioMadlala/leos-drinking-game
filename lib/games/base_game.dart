import 'package:leos_drinking_game/models/user_model.dart';

abstract class BaseGame {
  String get name;
  String get type;
  int get numberOfPlayers;

  String getPrompt(List<UserModel> players);
}
