import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leos_drinking_game/providers/game_provider.dart';

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

  List<String> imageList = [];

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/ios-images'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      imageList = imagePaths;
    });
  }

  selectTheFirst(GameProvider gameProvider) {
    gameProvider.newUserImoji == imageList[0];
    updateSelection(0);
  }

  @override
  void initState() {
    initData();
    // _initImages();
    // await selectTheFirst(widget.gameProvider);
    super.initState();
  }

  initData() async {
    await _initImages();
    await selectTheFirst(widget.gameProvider);
  }

  List<bool> selection = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //implement choose gender toggle buttons,
        const SizedBox(height: 10),
        ToggleButtons(
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
              mainAxisSize: MainAxisSize.max,
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

        const SizedBox(height: 10),
        GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: imageList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisExtent: 50,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  radius: 40,
                  onTap: () {
                    widget.gameProvider.updateNewUserImoji(imageList[index]);
                    updateSelection(index);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: currentAvatar == index
                        ? Colors.pinkAccent.shade100
                        : null,
                    child: Image.asset(
                      imageList[index],
                      width: 100,
                      height: 100,
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
