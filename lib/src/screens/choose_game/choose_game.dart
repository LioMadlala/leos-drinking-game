import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:leos_drinking_game/games/everyone_drinks.dart';
import 'package:leos_drinking_game/games/multi_naughty_dare.dart';
import 'package:leos_drinking_game/games/single_naughty_dare.dart';
import 'package:leos_drinking_game/games/single_naughty_answer_or_drink.dart';
import 'package:leos_drinking_game/games/single_player_truth_or_drink.dart';
import 'package:leos_drinking_game/games/multi_truth_or_drink.dart';
import 'package:leos_drinking_game/models/select_game_mode.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/screens/choose_game/game_screen.dart';
import 'package:leos_drinking_game/src/screens/players_screen/players_screen.dart';
import 'package:provider/provider.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({super.key});

  static const routeName = '/';

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  late InfiniteScrollController controller;
  int selectedIndex = 0;

  List<GameMode> gameModes = [
    GameMode(
      name: "Journey",
      description: "Sit back and let me get yall drunk",
      games: [
        EveryoneDrinks(),
        NaughtyAnswerOrDrink(),
        SingleNaughtyDare(),
        SingleTruthOrDrink(),
        MultiTruthOrDrink(),
        MultiNaughtyDare(),
      ],
    ),
    GameMode(
      name: "Everyone Drinks",
      description: "description",
      games: [
        EveryoneDrinks(),
      ],
    ),
    GameMode(
      name: "Soft Dare",
      description: "description",
      games: [
        SingleNaughtyDare(),
      ],
    ),
    GameMode(
      name: "Naughty Naughty Dare",
      description: "description",
      games: [
        MultiNaughtyDare(),
        SingleNaughtyDare(),
      ],
    ),
    GameMode(
      name: "Soft Questions",
      description: "description",
      games: [
        SingleTruthOrDrink(),
      ],
    ),
    GameMode(
      name: "Naughty Truth or Drink",
      description: "description",
      games: [
        NaughtyAnswerOrDrink(),
      ],
    ),
    GameMode(
      name: "Truth or Drink",
      description: "description",
      games: [
        MultiTruthOrDrink(),
      ],
    ),
    GameMode(
      name: "Multi Truth or Drink",
      description: "description",
      games: [
        MultiTruthOrDrink(),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 240, 107),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFfbe9d7),
              Color(0xFFf6d5f7),
            ],
          ),
        ),
        child: Consumer<GameProvider>(
          child: const CircularProgressIndicator(),
          builder: (context, gameProvider, child) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flexible(child: HorizontalListView()),
                  Center(
                    child: Image.asset(
                      'assets/logo/game_logo.png',
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    // width: 100,
                    child: InfiniteCarousel.builder(
                      itemCount: gameModes.length,
                      itemExtent: 200,
                      center: true,
                      anchor: 0.0,
                      physics: const BouncingScrollPhysics(),
                      velocityFactor: 0.3,
                      onIndexChanged: (index) {},
                      controller: controller,
                      axisDirection: Axis.horizontal,
                      scrollBehavior: const ScrollBehavior(),
                      loop: false,
                      itemBuilder: (context, itemIndex, realIndex) {
                        GameMode currentGameMode = gameModes[itemIndex];
                        return InkWell(
                          onTap: () async {
                            gameProvider.addGames(currentGameMode.games);
                            await Navigator.of(context).pushNamed(
                              PlayersScreen.routeName,
                              arguments: {'isStartGame': true},
                            );

                            if (gameProvider.users.length < 2) {
                              await Navigator.of(context).pushNamed(
                                PlayersScreen.routeName,
                                arguments: {'isStartGame': true},
                              );
                            } else {
                              Navigator.of(context)
                                  .pushNamed(GameScreen.routeName);
                            }

                            // gameProvider.addGames(currentGameMode.games);
                            // Navigator.of(context)
                            //     .pushNamed(GameScreen.routeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Center(
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentGameMode.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        currentGameMode.description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  // More UI components
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:
          Axis.horizontal, // Set the scroll direction to horizontal
      itemCount: 20, // Number of items in the list
      itemBuilder: (context, index) {
        return Container(
          width: 160.0, // Width of each item
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors
              .blue[(index % 9 + 1) * 100], // Different color for each item
          child: Center(
            child: Text(
              'Item $index',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
