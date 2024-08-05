import 'package:flutter/material.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';

import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage addPlayerAlert(BuildContext modalSheetContext,
    TextTheme textTheme, GameProvider gameProvider) {
  //device height
  double deviceHeight = MediaQuery.of(modalSheetContext).size.height;
  TextEditingController controller = TextEditingController();

  return WoltModalSheetPage(
    hasSabGradient: false,
    useSafeArea: true,
    // backgroundColor: Colors.white,

    stickyActionBar: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              //validator
              if (controller.text.isEmpty) {
                return;
              }
              await gameProvider.addUser(controller.text);
              Navigator.of(modalSheetContext).pop();
            },
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
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 8),
        ],
      ),
    ),
    topBarTitle: Text('Add Player', style: textTheme.titleSmall),
    isTopBarLayerAlwaysVisible: true,
    enableDrag: true,
    trailingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(8),
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter player name",
                hintStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: false,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          ImojiGrid(gameProvider: gameProvider),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    ),
  );
}

class ImojiGrid extends StatefulWidget {
  final GameProvider gameProvider;

  const ImojiGrid({super.key, required this.gameProvider});
  @override
  State<ImojiGrid> createState() => _ImojiGridState();
}

class _ImojiGridState extends State<ImojiGrid> {
  int currentAvatar = 0;

  updateSelection(int index) {
    setState(() {
      currentAvatar = index;
    });
  }

  //dummy data
  List<String> imojis = [
    "😎",
    "🤓",
    "🤠",
    "🤡",
    "🤖",
    "👽",
    "👾",
    "🤖",
  ];

  List<bool> selection = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //implement choose gender toggle buttons,
        const SizedBox(height: 10),
        Align(
          child: ToggleButtons(
            isSelected: selection,
            constraints: const BoxConstraints(minHeight: 40, minWidth: 80),
            borderRadius: BorderRadius.circular(30),
            textStyle: const TextStyle(fontSize: 12),
            onPressed: (index) {
              // handle button press
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < selection.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    selection[buttonIndex] = true;
                  } else {
                    selection[buttonIndex] = false;
                  }
                }
              });
            },
            children: const [
              Row(
                children: [
                  Icon(
                    Icons.male,
                    size: 18,
                    color: Colors.blue,
                  ),
                  Text("Male")
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.female,
                    size: 18,
                    color: Colors.pink,
                  ),
                  Text("Female")
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: imojis.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 50,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Material(
                  color: Colors.grey[200],
                  child: InkWell(
                    onTap: () {
                      widget.gameProvider.updateNewUserImoji("index");
                      updateSelection(index);
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          currentAvatar == index ? Colors.green : null,
                      child: Text(
                        imojis[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
