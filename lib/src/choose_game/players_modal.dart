import 'package:flutter/material.dart';
import 'package:leos_drinking_game/src/choose_game/players_list.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage playersModal(
    BuildContext modalSheetContext, TextTheme textTheme) {
  //device height
  double deviceHeight = MediaQuery.of(modalSheetContext).size.height;
  return WoltModalSheetPage(
    hasSabGradient: false,
    useSafeArea: true,
    // backgroundColor: Colors.white,
    stickyActionBar: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: Navigator.of(modalSheetContext).pop,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
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
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: Navigator.of(modalSheetContext).pop,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    topBarTitle: Text('All Players', style: textTheme.titleSmall),
    isTopBarLayerAlwaysVisible: true,
    enableDrag: true,
    trailingNavBarWidget: IconButton(
      padding: const EdgeInsets.all(8),
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ),
    scrollController: ScrollController(),
    child: SizedBox(
      height: deviceHeight,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          8,
          8,
          0,
        ),
        child: AllPlayersList(),
      ),
    ),
  );
}
