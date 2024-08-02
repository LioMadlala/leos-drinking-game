import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/choose_game/custom_button.dart';
import 'package:leos_drinking_game/src/choose_game/gradient_button.dart';
import 'package:leos_drinking_game/src/choose_game/players_modal.dart';
import 'package:leos_drinking_game/src/choose_game/top_users.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Column top3Drinkers2(GameProvider gameProvider, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (gameProvider.users.isNotEmpty)
        if (gameProvider.users[0].amountOfDrinksHad <= 0)
          Container()
        else
          TopUsersShowcase(
            topUsers: [
              gameProvider.users[0],
              gameProvider.users[1],
              gameProvider.users[2],
            ],
          ),
      Container(),
      const SizedBox(height: 10),
      RoundedButtonWidget(
          buttonText: "View Players",
          colors: const [
            Color(0xFFf9cdc3),
            Color(0xFFfacefb),
          ],
          onPressed: () async {
            WoltModalSheet.show<void>(
              context: context,
              pageListBuilder: (modalSheetContext) {
                final textTheme = Theme.of(context).textTheme;
                return [
                  playersModal(modalSheetContext, textTheme),
                ];
              },
              modalTypeBuilder: (context) {
                return const WoltBottomSheetType();
              },
              onModalDismissedWithBarrierTap: () {
                debugPrint('Closed modal sheet with barrier tap');
                Navigator.of(context).pop();
              },
            );
          }),
    ],
  );
}
