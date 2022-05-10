import 'dart:collection';

import 'package:flutter/material.dart';

Map<String, String> _iotBotNavBarButtons = {
  "My Farm": "/my-farm-page",
  "Home": "/home-page",
  "My Map": "/map-view-page",
};

Row iotBotNavBar(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: botNavBarButtons(context),
  );
}

/// Generates FloatingActionButtons for the botNavBar, where
/// all buttons not corresponding to the current page are added
List<Widget> botNavBarButtons(BuildContext context) {
  List<Widget> buttons = [];
  String? currentPageRoute = ModalRoute.of(context)?.settings.name.toString();

  _iotBotNavBarButtons.forEach((pageName, pageRoute) {
    if (currentPageRoute != null) {
      // do not add the button if its route is the page you are currently on
      if (!currentPageRoute.contains(pageRoute)) {
        buttons.add(iotActionButton(context, pageName, pageRoute));
      }
    }
  });

  return buttons;
}

// TODO: replace Text with Icon widget once icons are implemented
FloatingActionButton iotActionButton(
    BuildContext context,
    String toolTip,
    /*Icon icon,*/
    String link) {
  return FloatingActionButton(
    heroTag: "botNavBarButton_" + toolTip,
    child: Text(
      toolTip,
      textAlign: TextAlign.center,
    ),
    tooltip: toolTip,
    onPressed: () => Navigator.pushNamed(context, link),
  );
}
