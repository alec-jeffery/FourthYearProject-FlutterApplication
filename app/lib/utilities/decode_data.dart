import 'dart:convert';

import 'package:app/utilities/charts_class.dart';
import 'package:http/http.dart';

/// sensorName will determine which sensor data the chart will be made for
List<NodeDataSeries> iotDataSeriesFromJsonResponse(
    Response response, String sensorName) {
  List<NodeDataSeries> nodeDataSeries = [];
  List<dynamic> data = json.decode(response.body);
  String dataSensor;

  // for (var dataEntry in data) {
  for (int i = 0; i < data.length; i++) {
    dynamic dataEntry = data[i];
    dataSensor = dataEntry["sensor_name"];
    if (sensorName == dataSensor) {
      String dataTimeStamp = dataEntry["timestamp"];
      String hour = dataTimeStamp.substring(11, 13);
      String minute = i.toString();
      String minutes = minute.length < 2 ? "0" + minute : minute;
      // String seconds = dataTimeStamp.substring(17, 19);

      String timeValue = hour + ":" + minutes;
      int dataValue = dataEntry["value"].round();

      nodeDataSeries.add(NodeDataSeries(timeValue, dataValue));
      if (nodeDataSeries.length > 5) {
        break;
      }
    }
  }
  return nodeDataSeries;
}
