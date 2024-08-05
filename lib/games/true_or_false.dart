import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class TrueOrFalse implements BaseGame {
  @override
  String get name => 'True or False';

  @override
  String get type => 'true_false';

  @override
  int get numberOfPlayers => 1;

  final List<String> _statements = [
    'I have never broken a bone',
    'I can speak more than two languages',
    'I have been to every continent',
    'I am afraid of heights',
    'I have a hidden talent',
  ];
  String? _cachedPrompt;

  @override
  String getPrompt(List<UserModel> players) {
    if (_cachedPrompt != null) {
      return _cachedPrompt!;
    }
    final random = Random();
    final statement = _statements[random.nextInt(_statements.length)];
    _cachedPrompt = '@${players[0].name} True or False: $statement';
    return _cachedPrompt!;
  }
}
