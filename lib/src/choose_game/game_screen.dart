import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/choose_game/add_player_alert.dart';
import 'package:leos_drinking_game/src/choose_game/custom_button.dart';
import 'package:leos_drinking_game/src/choose_game/custom_chip.dart';
import 'package:leos_drinking_game/src/choose_game/custom_text.dart';
import 'package:leos_drinking_game/src/choose_game/gradient_button.dart';
import 'package:leos_drinking_game/src/choose_game/players_list.dart';
import 'package:leos_drinking_game/src/choose_game/players_modal.dart';
import 'package:leos_drinking_game/src/choose_game/selected_players.dart';
import 'package:leos_drinking_game/src/choose_game/top_drinkers.dart';
import 'package:leos_drinking_game/src/choose_game/top_drinkers2.dart';
import 'package:leos_drinking_game/src/choose_game/top_users.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
          child: Center(
            child: OrientationBuilder(
              builder: (context, orientation) {
                return Consumer<GameProvider>(
                    builder: (context, gameProvider, child) {
                  if (gameProvider.countdown > 0) {
                    return Center(
                        child: Text(gameProvider.countdown.toString()));
                  }

                  if (gameProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'Leos Drinking Game',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    gameProvider.currentGame.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 80),
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
                                      inputText: (gameProvider.currentGame
                                          .getPrompt(
                                              gameProvider.selectedUsers)),
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

                                top3Drinkers2(gameProvider, context),
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
                                    }),
                                const SizedBox(height: 10),
                              ],
                            ),
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
        const Text(
          'Drinking Game',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        CustomChip(
          text: 'Player',
          onTap: () async {
            // await gameProvider.addUser("Leo", "Male");

            await WoltModalSheet.show<void>(
              context: context,
              pageListBuilder: (modalSheetContext) {
                final textTheme = Theme.of(context).textTheme;
                return [
                  addPlayerAlert(modalSheetContext, textTheme, gameProvider),
                ];
              },
              modalTypeBuilder: (context) {
                return const WoltDialogType();
              },
              onModalDismissedWithBarrierTap: () {
                debugPrint('Closed modal sheet with barrier tap');
                Navigator.of(context).pop();
              },
            );
          },
          isBold: true,
          widget: const Icon(
            Icons.add,
            size: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}