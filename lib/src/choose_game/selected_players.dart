import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/choose_game/custom_chip.dart';

class SelectedPlayers extends StatelessWidget {
  final GameProvider gameProvider;
  const SelectedPlayers({
    super.key,
    required this.gameProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Players',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0, // Adjust spacing between items
            runSpacing: 8.0, // Adjust spacing between rows
            children: gameProvider.selectedUsers.map((user) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomChip(
                    text: user.name,
                    textColor: Colors.black,
                    textSize: 12,
                    height: 30,
                    isBold: false,
                    widget: const Text("😎"),
                  ),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
