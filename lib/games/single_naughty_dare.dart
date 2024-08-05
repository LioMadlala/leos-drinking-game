import 'dart:math';
import 'base_game.dart';
import '../models/user_model.dart';

class SingleNaughtyDare implements BaseGame {
  @override
  String get name => 'Naughty Dare 🤭';

  @override
  String get type => 'dare';

  @override
  int get numberOfPlayers => 1;

  final List<String> _dares = [
    "I dare you to kiss anyone you want in the room.",
    "I dare you to take off one item of clothing.",
    "I dare you to send a flirty text to someone in your contacts.",
    "I dare you to give someone a lap dance for one minute.",
    "I dare you to let someone in the room spank you.",
    "I dare you to whisper something dirty to the person on your right.",
    "I dare you to swap an item of clothing with the person opposite you.",
    "I dare you to make out with someone for one minute.",
    "I dare you to let someone write something on your body with a marker.",
    "I dare you to show your best fake orgasm.",
    "I dare you to give a hickey to the person on your left.",
    "I dare you to act out a sexy scene from a movie with someone.",
    "I dare you to take a body shot off someone.",
    "I dare you to suck someone's finger seductively for 30 seconds.",
    "I dare you to twerk for one minute.",
    "I dare you to send a voice message saying 'I want you' to a random contact.",
    "I dare you to let someone in the room take a provocative picture of you.",
    "I dare you to moan someone's name loudly.",
    "I dare you to exchange underwear with someone in the room.",
    "I dare you to flash the group for three seconds.",
    "I dare you to play 7 minutes in heaven with someone of your choice.",
    "I dare you to reveal your most intimate fantasy.",
    "I dare you to pretend to be a stripper for one minute.",
    "I dare you to let someone lick whipped cream off your body.",
    "I dare you to sit on someone's lap until your next turn.",
    "I dare you to kiss the neck of the person on your right.",
    "I dare you to describe your favorite sexual experience in detail.",
    "I dare you to let someone tickle you for 30 seconds.",
    "I dare you to demonstrate your favorite sexual position (with clothes on).",
    "I dare you to let someone bite your ear gently."
  ];

  @override
  String getPrompt(List<UserModel> players) {
    final random = Random();
    final dare = _dares[random.nextInt(_dares.length)];
    return '@${players[0].name} $dare';
  }
}
