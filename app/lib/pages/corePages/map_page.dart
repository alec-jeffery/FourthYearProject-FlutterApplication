import 'dart:io';

import 'package:app/utilities/http_methods.dart';
import 'package:app/widgets/http_response_popups.dart';
import 'package:app/widgets/scaffoldWidgets/bot_nav_bar.dart';
import 'package:app/widgets/scaffoldWidgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:charts_common/common.dart' as charts;
import 'package:http/http.dart' as http;
import '../../utilities/charts_class.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/*
IMPORTANT LINK - contains code to periodically fetch data from http endpoint:
https://stackoverflow.com/questions/59264620/fetch-api-data-automatically-with-interval-in-flutter
*/

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller = MapController();
  List notifications = [];

  void initState() {
    super.initState();
    getUserNotifications()
        .then((response) => notifications = json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Map"),
        ),
        drawer: iotDrawer(context),
        body: FlutterMap(
          mapController: controller,
          options: MapOptions(
            center: LatLng(45.351516, -75.669976),
            zoom: 10,
          ),
          layers: [
            TileLayerOptions(
              minZoom: 1,
              maxZoom: 20,
              backgroundColor: Colors.black,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: [
              Marker(
                width: 40,
                height: 40,
                point: LatLng(45.351516, -75.669976),
                builder: (context) => MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text("node0"),
                            children: <Widget>[
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/notifications");
                                  },
                                  child: Text("You have " +
                                      notifications.length.toString() +
                                      " notification(s)")),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Close"),
                              )
                            ],
                          );
                        });
                  },
                  child: const Icon(
                    Icons.pin_drop_sharp,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
              Marker(
                width: 40,
                height: 40,
                point: LatLng(45.38423608106515, -75.69837187433974),
                builder: (context) => MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text("node1"),
                            children: <Widget>[
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/notifications");
                                  },
                                  child: Text("You have " +
                                      notifications.length.toString() +
                                      " notification(s)")),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Close"),
                              )
                            ],
                          );
                        });
                  },
                  child: const Icon(
                    Icons.pin_drop_sharp,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
            ]),
          ],
        ),
        bottomNavigationBar: iotBotNavBar(context));
  }
}
