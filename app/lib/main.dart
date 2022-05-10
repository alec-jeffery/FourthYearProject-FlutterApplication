import 'package:flutter/material.dart';
import 'pages/menuPages/new_node_page.dart';
import 'pages/menuPages/view_notifications_page.dart';
import 'pages/corePages/user_node_page.dart';
import 'pages/loginPages/new_user_page.dart';
import 'pages/corePages/home_page.dart';
import 'pages/menuPages/new_threshold_page.dart';
import 'pages/loginPages/login_page.dart';
import 'pages/menuPages/view_threshold_page.dart';
import 'pages/corePages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Login UI',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[400]),
        home: const LoginPage(title: 'Flutter Login'),
        routes: {
          '/new-user-page': (BuildContext context) => const NewUserPage(),
          '/home-page': (BuildContext context) => const MyHomePage(),
          '/my-farm-page': (BuildContext context) => const UserNodePage(),
          '/new-plant-page': (BuildContext context) => const NewPlantPage(),
          '/threshold-page': (BuildContext context) => const ThresholdPage(),
          '/map-view-page': (BuildContext context) => const MapPage(),
          '/notifications': (BuildContext context) => const NotificationsPage(),
          '/user-node-page': (BuildContext context) => const UserNodePage(),
          '/new-node-page': (BuildContext context) => const NewNodePage(),
        });
  }
}
