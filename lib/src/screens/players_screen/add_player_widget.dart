import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';
import 'package:leos_drinking_game/src/widgets/add_player_alert.dart';
import 'package:provider/provider.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  TextEditingController controller = TextEditingController();
  ExpandableController expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      child: const SizedBox(),
      builder: (context, gameProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              // const SizedBox(height: 10),
              controller.text.isNotEmpty
                  ? ImojiGrid(gameProvider: gameProvider)
                  : const SizedBox(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: controller.text.isNotEmpty
                    ? () async {
                        if (controller.text.isEmpty) {
                          return;
                        }
                        await gameProvider.addUser(controller.text);
                        controller.clear();
                        // expandableController.toggle();
                        FocusScope.of(context).unfocus();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 11, 235, 127),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Add Player',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
