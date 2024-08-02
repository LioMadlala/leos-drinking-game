import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class RandomTruth implements BaseGame {
  @override
  String get name => 'Random Truth';

  @override
  String get type => 'truth';

  @override
  int get numberOfPlayers => 1;

  final List<String> _questions = [
    "What's the most embarrassing thing you've ever done?",
    "What's your biggest fear?",
    "What's your biggest regret?",
    "What's the craziest thing you've done in the name of love?",
    "What's one thing you'd change about yourself if you could?",
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random(players.length);
    final question = _questions[random.nextInt(_questions.length)];
    return '@${players[0].name} $question';
  }
}
