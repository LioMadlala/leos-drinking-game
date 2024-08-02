import 'package:flutter/material.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/choose_game/custom_chip.dart';
import 'package:provider/provider.dart';

class AllPlayersList extends StatelessWidget {
  final int? showTop;

  const AllPlayersList({super.key, this.showTop});

  List<UserModel> sortUsers(List<UserModel> users) {
    users.sort((a, b) => b.amountOfDrinksHad.compareTo(a.amountOfDrinksHad));
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final users = gameProvider.users;

    if (users.isEmpty) {
      return const Center(
        child: Text("No users found"),
      );
    }
    return ListView.builder(
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Text(
                "😎",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 6),
              Text(
                user.name,
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              const SizedBox(width: 10),
              Text(
                user.gender,
                style: TextStyle(
                  fontSize: 10,
                  color: user.gender == 'Male' ? Colors.cyan : Colors.pink,
                ),
              ),
              const Spacer(),
              CustomChip(
                text: "Drinks: ${user.amountOfDrinksHad}",
                isBold: false,
                bgColor: const Color.fromARGB(
                  255,
                  255,
                  240,
                  139,
                ),
                textColor: const Color.fromARGB(255, 133, 77, 14),
              )
            ],
          ),
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
        ],
      ),
    );
  }
}
