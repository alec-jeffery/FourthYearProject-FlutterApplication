import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/common.dart' as charts;
import 'package:http/http.dart';
import '../../utilities/charts_class.dart';

/*
IMPORTANT LINK - contains code to periodically fetch data from http endpoint:
https://stackoverflow.com/questions/59264620/fetch-api-data-automatically-with-interval-in-flutter
*/

class NewPlantPage extends StatefulWidget {
  const NewPlantPage({Key? key}) : super(key: key);

  @override
  State<NewPlantPage> createState() => _NewPlantPageState();
}

class _NewPlantPageState extends State<NewPlantPage> {
  TextEditingController nodeIdController = TextEditingController();
  TextEditingController plantTypeController = TextEditingController();
  TextEditingController sensorTypeController = TextEditingController();
  TextEditingController minFieldController = TextEditingController();
  TextEditingController maxFieldController = TextEditingController();

  // void initState() {
  //   super.initState();
  //   // _sensorData = getAllSensorData();
  //   // _sensorData = getSensorData("temperature");

  @override
  Widget build(BuildContext context) {
    final nodeId = TextField(
        controller: nodeIdController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Node Id",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final plantTypeField = TextField(
        controller: plantTypeController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Plant Type",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final sensorTypeField = TextField(
        controller: sensorTypeController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Sensor Type",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final minField = TextField(
        controller: minFieldController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Minimum Value",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final maxField = TextField(
        controller: maxFieldController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Maximum Value",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final addThresholdDataButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              postTelemetryData(
                nodeIdController.text,
                plantTypeController.text,
                sensorTypeController.text,
                minFieldController.text,
                maxFieldController.text,
              ).then((response) {
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(context,
                        "Sucess!", "Threshold data successfully added"),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(
                        context, "Error", "Threshold data unable to be added"),
                  ).then((value) => Navigator.pop(context));
                }
              });
              //print("we made an account");
              //Navigator.pop(context);
            },
            child:
                const Text('Add Threshold Data', textAlign: TextAlign.center)));

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Plant Threshold Data"),
      ),
      drawer: iotDrawer(context),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              // Text("nothing to see here"),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text("Enter all values",
                        //     style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 25.0),
                        nodeId,
                        const SizedBox(height: 25.0),
                        plantTypeField,
                        const SizedBox(height: 25.0),
                        sensorTypeField,
                        const SizedBox(height: 25.0),
                        minField,
                        const SizedBox(height: 25.0),
                        maxField,
                        const SizedBox(height: 25.0),
                        addThresholdDataButton,
                      ]),
                ),
              ),
              // SizedBox(height: 25.0),
              // addThresholdDataButton,
            ])),
      ),
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
