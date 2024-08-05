import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class MultiTruthOrDrink implements BaseGame {
  @override
  String get name => 'True or Drink';

  @override
  String get type => 'true_false';

  @override
  int get numberOfPlayers => 1;

  final List<String> _statements = [
    'Who has broken a bone ',
    'Who is famous in the room ',
    'Who has the most *TikTok Followers* ',
    'Who has the most *Facebook Friends* ',
    'Who is top 3 with most *Instagram Followers* ',
    'Who can speak more than two languages ',
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random();
    final statement = _statements[random.nextInt(_statements.length)];

    return '@Everyone $statement drinks';
  }
}
