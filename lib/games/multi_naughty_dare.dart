import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class MultiNaughtyDare implements BaseGame {
  @override
  String get name => 'Naughty Dare';

  @override
  String get type => 'dare';

  @override
  int get numberOfPlayers => 2;

  final List<String> _dares = [
    "To Let another player post a status on your whatsapp status",
    "To Kiss anyone you think they like",
    "To ask anyone they like a naughty question.",
    "To dare anyone they like to kiss someone in the room.",
    "To challenge anyone they like to a staring contest with a seductive twist.",
    "To whisper a secret into anyone’s ear.",
    "To exchange an item of clothing with anyone they choose.",
    "To give a compliment to anyone they like, but make it spicy.",
    "To perform a dance for anyone they choose.",
    "To send a flirty text to anyone in the room.",
    "To let anyone in the room draw something on their body.",
    "To confess a secret to anyone they choose.",
    "To propose a toast with anyone they like, making it as cheeky as possible.",
    "To take a selfie with anyone they like, but make it fun and provocative.",
    "To ask anyone they choose to describe their wildest fantasy.",
    "To share an embarrassing story with anyone they like.",
    "To let anyone they choose give them a dare in return.",
    "To choose someone to give a seductive look to for 10 seconds.",
    "To challenge anyone to a dance-off.",
    "To ask anyone to tell their most scandalous secret.",
    "To compliment anyone's best feature.",
    "To ask anyone to share their favorite romantic moment.",
    "To let anyone pick a song and sing it together.",
    "To ask anyone to demonstrate their best dance move.",
    "To challenge anyone to a fun physical activity, like arm wrestling or a silly dance.",
    "To propose a toast to anyone they like, making it humorous and playful.",
    "To let anyone choose a funny nickname for them to use for the rest of the game."
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random();
    final dare = _dares[random.nextInt(_dares.length)];
    return '@${players[0].name} Dare @${players[1].name} $dare';
  }
}
