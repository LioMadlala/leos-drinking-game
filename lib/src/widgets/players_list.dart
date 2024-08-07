import 'package:flutter/material.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/screens/choose_game/game_screen.dart';
import 'package:leos_drinking_game/src/widgets/custom_chip.dart';
import 'package:leos_drinking_game/src/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

class AllPlayersList extends StatelessWidget {
  final int? showTop;
  final bool isStartGame = true;

  const AllPlayersList({super.key, this.showTop});

  List<UserModel> sortUsers(List<UserModel> users) {
    users.sort((a, b) => b.amountOfDrinksHad.compareTo(a.amountOfDrinksHad));
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final users = gameProvider.users;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        usersListView(users),
        if (isStartGame && users.length > 1)
          Column(
            children: [
              const SizedBox(height: 10),
              RoundedButtonWidget(
                buttonText: "Lets Drink!",
                colors: const [
                  Color.fromARGB(255, 208, 255, 251),
                  Color.fromARGB(255, 147, 224, 255),
                ],
                onPressed: () async {
                  // Navigator.of(context).pushNamed(GameScreen.routeName);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
      ],
    );
  }

  Column usersListView(List<UserModel> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // top3Drinkers(gameProvider, context),
        if (users.isNotEmpty)
          const Row(
            children: [
              Text(
                "Players",
                style: TextStyle(
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Text(
                "Top Drinkers First",
                style: TextStyle(
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        const SizedBox(height: 4),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: showTop ?? users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: UserCard(user: user),
            );
          },
        ),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        gradient: const LinearGradient(
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Image.asset(
                user.imoji,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    user.gender,
                    style: TextStyle(
                      fontSize: 10,
                      color: user.gender == 'Male' ? Colors.cyan : Colors.pink,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(width: 10),
              if (user.linkedWith != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RichText(
                    text: TextSpan(
                      text: "💗 Joling with ",
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                      children: [
                        TextSpan(
                          text: user.linkedWith,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              CustomChip(
                text: "Drinks: ${user.amountOfDrinksHad}",
                isBold: false,
                textColor: const Color.fromARGB(255, 133, 77, 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
