import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/choose_game/custom_button.dart';
import 'package:leos_drinking_game/src/choose_game/players_modal.dart';
import 'package:leos_drinking_game/src/choose_game/top_users.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
