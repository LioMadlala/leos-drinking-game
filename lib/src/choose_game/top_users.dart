import 'package:flutter/material.dart';
import 'package:leos_drinking_game/models/user_model.dart';

class TopUsersShowcase extends StatelessWidget {
  final List<UserModel> topUsers;

  const TopUsersShowcase({super.key, required this.topUsers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top drinkers',
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topUsers[0].amountOfDrinksHad > 0)
              _buildUserAvatar(
                context: context,
                position: 0,
                user: topUsers[0],
              ),
            if (topUsers[1].amountOfDrinksHad > 0)
              _buildUserAvatar(
                context: context,
                position: 1,
                user: topUsers[1],
              ),
            if (topUsers[2].amountOfDrinksHad > 0)
              _buildUserAvatar(
                context: context,
                position: 2,
                user: topUsers[2],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserAvatar({
    required BuildContext context,
    required UserModel user,
    required int position,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey.shade100,
              child: Text(
                '${position + 1}',
                style: TextStyle(
                  fontSize: 12,
                  color: _getMedalColor(position),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minWidth: (80 - user.amountOfDrinksHad) +
                      (user.amountOfDrinksHad * 5.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${user.amountOfDrinksHad} drinks",
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ])),
    );
  }

  Color _getMedalColor(int index) {
    switch (index) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
