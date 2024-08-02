import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class RandomDare implements BaseGame {
  @override
  String get name => 'Random Dare';

  @override
  String get type => 'dare';

  @override
  int get numberOfPlayers => 2;

  final List<String> _dares = [
    'Kiss anyone you think they like',
    'Do your best impression of another player',
    'Show the most embarrassing photo on your phone',
    'Do 10 push-ups',
    'Let another player post a status on your social media',
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random();
    final dare = _dares[random.nextInt(_dares.length)];
    return '@${players[0].name} Dare @${players[1].name} to $dare';
  }
}
