import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:app/widgets/scaffoldWidgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Response> _sensorData;

  @override
  void initState() {
    super.initState();
    _sensorData = getAllSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: iotDrawer(context),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _sensorData,
              builder:
                  (BuildContext context, AsyncSnapshot<Response> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Latest Node Data",
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 2.0),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 25.0),
                        SizedBox(
                            height: 300,
                            child: iotHomePageBody(context,
                                decodeLatestData(snapshot.data, context))),
                      ]);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ]),
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
