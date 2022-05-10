import 'package:app/utilities/decode_data.dart';
import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../utilities/charts_class.dart';

/*
IMPORTANT LINK - contains code to periodically fetch data from http endpoint:
https://stackoverflow.com/questions/59264620/fetch-api-data-automatically-with-interval-in-flutter
*/

class MyFarmPage extends StatefulWidget {
  final String node;

  const MyFarmPage({Key? key, required this.node}) : super(key: key);

  @override
  State<MyFarmPage> createState() => _MyFarmPageState();
}

class _MyFarmPageState extends State<MyFarmPage> {
  late Future<Response> _sensorData;

  @override
  void initState() {
    super.initState();
    // _sensorData = getNodeTelemetryData(widget.node);
    // _sensorData = getSensorData("temperature");
    _sensorData = getAllSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Farm Page - ${widget.node}"),
      ),
      drawer: iotDrawer(context),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              FutureBuilder(
                future: _sensorData,
                builder:
                    (BuildContext context, AsyncSnapshot<Response> snapshot) {
                  // String decodedData;
                  Response? data = snapshot.data;
                  if (snapshot.hasData && data == null) {
                    return httpRequestPopup(
                        context, "Error", "Could not retrieve Node Data");
                  } else if (snapshot.hasData && data != null) {
                    if (data.body.length < 2) {
                      return const Text("No node data has been made yet");
                    }
                    // decodedData = decodeGetAllData(snapshot.data);
                    //Replace with whatever widget you want
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NodeDataChart(
                            dataList: iotDataSeriesFromJsonResponse(
                                data, "temperature"),
                            chartName: "Temperature",
                          ),
                          NodeDataChart(
                            dataList:
                                iotDataSeriesFromJsonResponse(data, "humidity"),
                            chartName: "Humidity",
                          ),
                          NodeDataChart(
                            dataList: iotDataSeriesFromJsonResponse(
                                data, "soil_moisture"),
                            chartName: "Soil Moisture",
                          ),
                        ]);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ])),
      ),
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
