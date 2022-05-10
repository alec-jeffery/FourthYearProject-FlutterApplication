import 'dart:io';
import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/common.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../utilities/charts_class.dart';
import 'dart:convert';

/*
IMPORTANT LINK - contains code to periodically fetch data from http endpoint:
https://stackoverflow.com/questions/59264620/fetch-api-data-automatically-with-interval-in-flutter
*/

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late Future<Response> _userNotifications;

  void initState() {
    super.initState();
    _userNotifications = getUserNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notifications"),
      ),
      drawer: iotDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: _userNotifications,
            builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
              // String decodedData;
              Response? data = snapshot.data;
              if (snapshot.hasData && data == null) {
                return httpRequestPopup(
                    context, "Error", "Could not retrieve Node Data");
              } else if (snapshot.hasData && data != null) {
                if (data.body.length < 2) {
                  return const Text("No node data has been made yet");
                }
                List<dynamic> userNotifications = json.decode(data.body);

                return SizedBox(
                    height: 500,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: userNotifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(2.0),
                            child: Column(
                              children: <Widget>[
                                if (userNotifications[index]["timestamp"] !=
                                    null) ...[
                                  Text(
                                      "Timestamp: ${userNotifications[index]["timestamp"]}"),
                                ],
                                if (userNotifications[index]["value"] !=
                                    null) ...[
                                  Text(
                                      "Value: ${userNotifications[index]["value"]}"),
                                ],
                                if (userNotifications[index]["sensor_name"] !=
                                    null) ...[
                                  Text(
                                      "Sensor: ${userNotifications[index]["sensor_name"]}"),
                                ],
                                if (userNotifications[index]["message"] !=
                                    null) ...[
                                  Text(
                                      "Message: ${userNotifications[index]["message"]}"),
                                ],
                              ],
                            ));
                      },
                    ));
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
