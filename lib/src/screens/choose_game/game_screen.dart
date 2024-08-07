import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/screens/players_screen/players_screen.dart';
import 'package:leos_drinking_game/src/widgets/custom_chip.dart';
import 'package:leos_drinking_game/src/widgets/custom_text.dart';
import 'package:leos_drinking_game/src/widgets/gradient_button.dart';
import 'package:leos_drinking_game/src/widgets/players_list.dart';
import 'package:leos_drinking_game/src/widgets/wh0_drank_button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  static const routeName = '/game-screen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false).startGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[100],
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFfbe9d7),
                Color(0xFFf6d5f7),
              ],
            ),
          ),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Consumer<GameProvider>(
                  builder: (context, gameProvider, child) {
                if (gameProvider.countdown > 0) {
                  return Center(child: Text(gameProvider.countdown.toString()));
                }

                if (gameProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 0),

                        //Game logo
                        Center(
                          child: Image.asset(
                            'assets/logo/game_logo.png',
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // if (width < 600)
                        //   PhoneSize(gameProvider)
                        // if (width > 600)
                        _phoneSize(gameProvider),
                        // _tabletSize(gameProvider),

                        // PhoneSize(gameProvider),
                        const Text("Leo is about to die soon popup"),
                        const Text(
                            "Compulsory - Aya is Sober as hell. give him a Shot"),
                        const Text("Tic tac toe game "),
                        const Text(
                            "Players pick a number and the closest one drinks"),
                        const Text(
                          "Player 1 selects a number and player 2 gusses the number, if its close by 10 player 1 drinks",
                        ),

                        const SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  Container _tabletSize(GameProvider gameProvider) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CardHeader(
                    gameProvider: gameProvider,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFfbe9d7),
                          Color(0xFFf6d5f7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        inputText: (gameProvider.gameWithPrompt().prompt),
                      ),
                    ),
                    // child: Center(
                    //   child: Text(
                    // (gameProvider.currentGame.getPrompt(
                    //     gameProvider.selectedUsers)),
                    //     textAlign: TextAlign.center,
                    //     style: const TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 6,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Who drank? 🤭",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            itemCount: gameProvider.selectedUsers.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              UserModel user =
                                  gameProvider.selectedUsers[index];
                              return WhoDrankButton(
                                isSelected:
                                    gameProvider.whoDrinks.contains(user),
                                user: user,
                                onTap: () {
                                  gameProvider.addToDrink(user);
                                },
                              );

                              // return ListTile(
                              //   title: Text(
                              //       gameProvider.users[index].name),
                              //   subtitle: Text(gameProvider
                              //       .users[index].amountOfDrinksHad
                              //       .toString()),
                              // );
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 5),
                  RoundedButtonWidget(
                      buttonText: "Next Round",
                      colors: const [
                        Color(0xFF57ebde),
                        Color(0xFFaefb2a),
                      ],
                      onPressed: () async {
                        if (!gameProvider.isLoading) {
                          gameProvider.completeTurn();
                        }
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text("sdwdsf"),
                  AllPlayersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _phoneSize(GameProvider gameProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            gameProvider: gameProvider,
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFfbe9d7),
                  Color(0xFFf6d5f7),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomTextWidget(
                inputText: (gameProvider.gameWithPrompt().prompt),
              ),
            ),
            // child: Center(
            //   child: Text(
            // (gameProvider.currentGame.getPrompt(
            //     gameProvider.selectedUsers)),
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ),
          // Animate(
          //   effects: const [
          //     FadeEffect(),
          //     ScaleEffect(),
          //   ],
          //   child: const Text("Hello World!"),
          // ),
          // const Text("Hello World!")
          //     .animate()
          //     .fadeIn() // uses `Animate.defaultDuration`
          //     .scale() // inherits duration from fadeIn
          //     .move(
          //         delay: 300.ms,
          //         duration: 600
          //             .ms) // runs after the above w/new duration
          // ,
          const SizedBox(height: 8),

          Container(
              padding: const EdgeInsets.symmetric(
                // horizontal: 6,
                vertical: 6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Who drank? 🤭",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: gameProvider.selectedUsers.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserModel user = gameProvider.selectedUsers[index];
                      return WhoDrankButton(
                        isSelected: gameProvider.whoDrinks.contains(user),
                        user: user,
                        onTap: () {
                          gameProvider.addToDrink(user);
                        },
                      );

                      // return ListTile(
                      //   title: Text(
                      //       gameProvider.users[index].name),
                      //   subtitle: Text(gameProvider
                      //       .users[index].amountOfDrinksHad
                      //       .toString()),
                      // );
                    },
                  ),
                ],
              )),
          const SizedBox(height: 10),

          RoundedButtonWidget(
            buttonText: "Next Round",
            colors: const [
              Color(0xFF57ebde),
              Color(0xFFaefb2a),
            ],
            onPressed: () async {
              if (!gameProvider.isLoading) {
                gameProvider.completeTurn();
              }
            },
          ),
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final GameProvider gameProvider;

  const CardHeader({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            gameProvider.currentGame.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //   decoration: BoxDecoration(
        //     color: Colors.orangeAccent.withOpacity(0.2),
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        //   child: Text(
        //     gameProvider.currentGame.name,
        //     style: const TextStyle(
        //       fontSize: 12,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        const Spacer(),
        CustomChip(
          text: 'View Players',
          onTap: () async {
            Navigator.of(context).pushNamed(PlayersScreen.routeName);
          },
          isBold: false,
        ),
      ],
    );
  }
}
