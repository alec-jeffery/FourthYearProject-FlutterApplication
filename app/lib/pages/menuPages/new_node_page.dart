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

class NewNodePage extends StatefulWidget {
  const NewNodePage({Key? key}) : super(key: key);

  @override
  State<NewNodePage> createState() => _NewNodePageState();
}

class _NewNodePageState extends State<NewNodePage> {
  TextEditingController LocationTypeController = TextEditingController();
  TextEditingController NodeIdTypeController = TextEditingController();

  // void initState() {
  //   super.initState();
  //   // _sensorData = getAllSensorData();
  //   // _sensorData = getSensorData("temperature");

  @override
  Widget build(BuildContext context) {
    final locationTypeField = TextField(
        controller: LocationTypeController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Location of Node",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nodeIdTypeField = TextField(
        controller: NodeIdTypeController,
        obscureText: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "NodeID",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final addNodeButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xff01A0C7),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              postNewNode(
                      LocationTypeController.text, NodeIdTypeController.text)
                  .then((response) {
                if (response.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(context,
                        "Sucess!", "Your new node has been successfully added"),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => httpRequestPopup(
                        context, "Error", "Node unable to be added"),
                  ).then((value) => Navigator.pop(context));
                }
              });
              //print("we made an account");
              //Navigator.pop(context);
            },
            child: const Text('Add New Node', textAlign: TextAlign.center)));

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Node"),
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
                        nodeIdTypeField,
                        const SizedBox(height: 25.0),
                        locationTypeField,
                        const SizedBox(height: 25.0),
                        addNodeButton,
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
