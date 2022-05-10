import 'package:flutter/material.dart';

Drawer iotDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(''),
        ),
        ListTile(
          title: const Text('Add New Node'),
          onTap: () => Navigator.pushNamed(context, '/new-node-page'),
        ),
        ListTile(
          title: const Text('Add New Threshold'),
          onTap: () => Navigator.pushNamed(context, '/new-plant-page'),
        ),
        ListTile(
          title: const Text("Your Thresholds"),
          onTap: () => Navigator.pushNamed(context, "/threshold-page"),
        ),
        ListTile(
          title: const Text("Your Notifications"),
          onTap: () => Navigator.pushNamed(context, "/notifications"),
        ),
        ListTile(
          title: const Text('LOGOUT'),
          // ****** make sure this is "popUntil" is secure ******* //
          // popUntil will pop the Flutter Navigation stack until it arrives
          // at "withName", in this case is the home directory IE LoginPage (main.dart)-
          onTap: () => Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          ),
        ),
      ],
    ),
  );
}
