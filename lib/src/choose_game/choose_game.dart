import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:leos_drinking_game/src/choose_game/game_screen.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({super.key});

  static const routeName = '/';

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  late InfiniteScrollController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 240, 107),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFfbe9d7),
              Color(0xFFf6d5f7),
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flexible(child: HorizontalListView())
              SizedBox(
                height: 250,
                child: InfiniteCarousel.builder(
                  itemCount: 10,
                  itemExtent: 200,
                  center: true,
                  anchor: 0.0,
                  physics: const BouncingScrollPhysics(),
                  velocityFactor: 0.3,
                  onIndexChanged: (index) {},
                  controller: controller,
                  axisDirection: Axis.horizontal,
                  scrollBehavior: const ScrollBehavior(),
                  loop: false,
                  itemBuilder: (context, itemIndex, realIndex) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "JOURNEY",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Sit back and let me get yall drunk",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              // More UI components
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:
          Axis.horizontal, // Set the scroll direction to horizontal
      itemCount: 20, // Number of items in the list
      itemBuilder: (context, index) {
        return Container(
          width: 160.0, // Width of each item
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors
              .blue[(index % 9 + 1) * 100], // Different color for each item
          child: Center(
            child: Text(
              'Item $index',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
