import 'package:app/pages/corePages/my_farm_page.dart';
import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:app/widgets/scaffoldWidgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class UserNodePage extends StatefulWidget {
  const UserNodePage({Key? key}) : super(key: key);

  @override
  State<UserNodePage> createState() => _UserNodePageState();
}

class _UserNodePageState extends State<UserNodePage> {
  late Future<String?> _numberOfNodes;

  @override
  void initState() {
    super.initState();
    var storage = const FlutterSecureStorage();
    _numberOfNodes = storage.read(key: "numberOfNodes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Farm Page - Node Selection"),
      ),
      drawer: iotDrawer(context),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _numberOfNodes,
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData && snapshot.data == null) {
                  return httpRequestPopup(
                      context, "Error", "Could not retrieve Node Data");
                } else if (snapshot.hasData && snapshot.data != null) {
                  int numberOfNodes = int.parse(snapshot.data!);
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Select Which Node You Would Like To See",
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 2.0),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 25.0),
                        SizedBox(
                          height: 500,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: numberOfNodes,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyFarmPage(
                                                          node: "node${index}",
                                                        )));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(height: 10),
                                              Text("node${index}"),
                                              const SizedBox(height: 10),
                                            ],
                                          )),
                                    ],
                                  ));
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
      bottomNavigationBar: iotBotNavBar(context),
    );
  }
}
