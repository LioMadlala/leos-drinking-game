import 'dart:math';

import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/games/base_game.dart';

class EveryoneDrinks implements BaseGame {
  @override
  String get name => 'Everyone Drinks';

  @override
  String get type => 'dare';

  @override
  int get numberOfPlayers => 2;

  final List<String> _dares = [
    'Drink 😂',
    'take a shot 🥃',
    'Drink a beer 🍺',
    'Drink a glass of *wine* 🍷',
    'Drink a cocktail 🍹',
    'Drink a glass of *water* 🚰',
    'Drink a glass of *juice* 🧃',
    'Drink a glass of milk 🥛',
    'Drink a glass of *soda* 🥤',
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random();
    final dare = _dares[random.nextInt(_dares.length)];
    return '@Everyone $dare';
  }
}
