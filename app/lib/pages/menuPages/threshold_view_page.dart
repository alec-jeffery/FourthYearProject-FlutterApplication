import 'dart:io';

import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/common.dart' as charts;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../utilities/charts_class.dart';
import 'dart:convert';

/*
IMPORTANT LINK - contains code to periodically fetch data from http endpoint:
https://stackoverflow.com/questions/59264620/fetch-api-data-automatically-with-interval-in-flutter
*/

class ThresholdPage extends StatefulWidget {
  const ThresholdPage({Key? key}) : super(key: key);

  @override
  State<ThresholdPage> createState() => _ThresholdPageState();
}

class _ThresholdPageState extends State<ThresholdPage> {
  late Future<Response> _userThresholds;
  var storage = const FlutterSecureStorage();

  void initState() {
    super.initState(); // email used for testing change this later
    _userThresholds = getUserThresholds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Thresholds"),
      ),
      drawer: iotDrawer(context),
      body: SizedBox(
        height: 500,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _userThresholds,
                builder:
                    (BuildContext context, AsyncSnapshot<Response> snapshot) {
                  Response? userThresholds = snapshot.data;
                  if (snapshot.hasData && userThresholds == null) {
                    return httpRequestPopup(
                        context, "Error", "Could not retrieve Threshold Data");
                  } else if (snapshot.hasData && userThresholds != null) {
                    List userThresholdsDecoded =
                        json.decode(userThresholds.body);
                    return Column(children: [
                      SizedBox(
                        height: 500,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 5),
                          itemCount: userThresholdsDecoded.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(2.0),
                                child: MaterialButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                                title: const Text(
                                                    "Would you like to delete this Threshold?"),
                                                children: <Widget>[
                                                  MaterialButton(
                                                    elevation: 5.0,
                                                    onPressed: () {
                                                      deleteUserThresholds(
                                                          userThresholdsDecoded[
                                                                  index]
                                                              ["plantType"],
                                                          userThresholdsDecoded[
                                                                  index]
                                                              ["sensor_name"]);
                                                      Navigator.pushNamed(
                                                          context,
                                                          "/threshold-page");
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  MaterialButton(
                                                    elevation: 5.0,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                ]);
                                          });
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            "NodeId: ${userThresholdsDecoded[index]["nodeId"]}"),
                                        Text(
                                            "Plant: ${userThresholdsDecoded[index]["plantType"]}"),
                                        Text(
                                            "Sensor: ${userThresholdsDecoded[index]["sensor_name"]}"),
                                        Text(
                                            "Minimum: ${userThresholdsDecoded[index]["min"]}"),
                                        Text(
                                            "Maximum: ${userThresholdsDecoded[index]["max"]}")
                                      ],
                                    )));
                          },
                        ),
                      ),
                    ]);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ]),
      ),
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
