import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/widgets/top_users.dart';

Column top3Drinkers(GameProvider gameProvider, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (gameProvider.users.isNotEmpty)
        TopUsersShowcase(
          topUsers: [
            gameProvider.users[0],
            gameProvider.users[1],
            gameProvider.users[2],
          ],
        ),
      Container(),
      const SizedBox(height: 10),
    ],
  );
}
