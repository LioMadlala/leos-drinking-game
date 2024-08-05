import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class NaughtyAnswerOrDrink implements BaseGame {
  @override
  String get name => 'Answer or Drink';

  @override
  String get type => 'truth';

  @override
  int get numberOfPlayers => 1;

  final List<String> _questions = [
    "Have you ever had a one-night stand?",
    "What's the most inappropriate thing you've ever said to someone?",
    "Have you ever cheated on a partner?",
    "What's your most scandalous fantasy?",
    "What's the weirdest place you've ever had sex?",
    "Have you ever been caught in the act?",
    "What's the naughtiest thing you've done in public?",
    "What's the most risqué photo you've ever sent?",
    "What's the biggest lie you've ever told to get out of trouble?",
    "Have you ever hooked up with someone you shouldn't have?",
    "What's the dirtiest text you've ever received?",
    "Have you ever pretended to be someone else online?",
    "Have you ever been caught in the act?",
    "What's the naughtiest thing you've done in public?",
    "What's the most risqué photo you've ever sent?",
    "What's the biggest lie you've ever told to get out of trouble?",
    "Have you ever hooked up with someone you shouldn't have?",
    "What's the dirtiest text you've ever received?",
    "Have you ever pretended to be someone else online?",
    "How many people have you slept with?",
    "Have you ever had sex in a public place?",
    "What's the longest you've gone without sex?",
    "Have you ever had a friends-with-benefits arrangement?",
    "What's the best sex you've ever had?",
    "Have you ever had a threesome or more?",
    "What's your favorite position?",
    "Have you ever faked an orgasm?",
    "Have you ever tried role-playing in bed?",
    "What's the most unusual thing that turns you on?",
    "Have you ever used sex toys?",
    "What's the kinkiest thing you've ever done?",
    "Have you ever had sex with someone you met online?",
    "Have you ever had sex on the first date?",
    "Have you ever had a crush on a friend's partner?",
    "What's the most number of times you've had sex in one day?",
    "What's the dirtiest thought you've ever had about a total stranger?",
    "Have you ever had sex with more than one person in a 24-hour period?",
    "What's your favorite type of foreplay?",
    "Have you ever been to a sex club or swingers' party?",
    "What's the most awkward sexual experience you've ever had?",
    "Have you ever sent or received nudes?",
    "Have you ever had sex with someone much older or younger than you?",
    "What's the most adventurous place you've had sex?",
    "Have you ever had sex with a coworker?"
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random(players.length);
    final question = _questions[random.nextInt(_questions.length)];
    return '@${players[0].name} $question';
  }
}
