import 'package:flutter/material.dart';
import 'package:leos_drinking_game/src/widgets/custom_button.dart';
import 'package:leos_drinking_game/src/widgets/players_list.dart';
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
          customButton(
            text: 'Close',
            onPressed: Navigator.of(modalSheetContext).pop,
            bgColor: const Color.fromARGB(255, 227, 241, 234),
            textColor: Colors.black,
            textSize: 12,
            height: 50,
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
