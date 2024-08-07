import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/screens/players_screen/add_player_widget.dart';
import 'package:leos_drinking_game/src/widgets/players_list.dart';
import 'package:provider/provider.dart';

class PlayersScreen extends StatefulWidget {
  final bool isStartGame;
  const PlayersScreen({
    super.key,
    required this.isStartGame,
  });
  static const routeName = '/players-screen';

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        // physics: const NeverScrollableScrollPhysics(),

        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFfbe9d7),
                Color.fromARGB(255, 52, 204, 241),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.isStartGame ? 'Start Game' : "Players",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  coolEmojis(),
                  const SizedBox(
                    height: 10,
                  ),
                  const AddNewUser(),
                  const SizedBox(
                    height: 10,
                  ),
                  const AllPlayersList(),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Consumer<GameProvider> coolEmojis() {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Center(
          // ignore: prefer_is_empty
          child: gameProvider.users.length < 1
              ? Column(
                  children: [
                    Image.asset(
                      'assets/ios-images/Person=Ed, Skin Tone=White, Posture=24 Fisting.png',
                      scale: 3,
                    ),
                    const Text(
                      "Let's add some Drinkers!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Image.asset(
                      'assets/ios-images/Person=Ed, Skin Tone=White, Posture=17 Happy Winking.png',
                      scale: 3,
                    ),
                    const Text(
                      "Let's add one more Drinker!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
