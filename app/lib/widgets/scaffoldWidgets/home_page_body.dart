import 'package:flutter/material.dart';

Widget iotHomePageBody(BuildContext context, Map latestSensorData) {
  var keys = latestSensorData.keys.toList();
  if (latestSensorData.length > 1) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: keys.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(2.0),
              child: Column(
                children: <Widget>[
                  Text("Sensor: ${keys[index]}"),
                  Text("Timestamp: ${latestSensorData[keys[index]]["time"]}"),
                  Text("Value: ${latestSensorData[keys[index]]["value"]}")
                ],
              ));
        });
  } else {
    return Text("No node data yet!", textAlign: TextAlign.center);
  }
}
