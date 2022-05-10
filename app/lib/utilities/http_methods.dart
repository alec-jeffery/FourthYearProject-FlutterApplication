import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'charts_class.dart';

// retrieved IP from: cmd line -> ipconfig -> Ethernet adapter VirtualBox Host-Only Network:, IPv4

// ------------- METHOD'S TO GET & POST ------------- //

// http://localhost:5000/api/users/register?name=Campbell&email=test@test.com&password=test123&password2=test123
Future<void> makeGetRequest() async {
  Response response = await http.get(Uri.parse('http://LOCAL.IP.ADDRESS:5000'));
  print('Status code: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');
}

Future<Response> createUser(
    String name, String email, String password, String password2) async {
  final response = await http.post(
    Uri.parse('https://carletonsmartgarden.ca/api/users/register'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'password2': password2
    }),
  );
  //print('Status code: ${response.statusCode}');
  //print('Headers: ${response.headers}');
  //print('Body: ${response.body}');
  return response;
  // if (response.statusCode == 200) {
  //   return Future<bool>.value(true);
  // } else if (response.statusCode == 400) {
  //   print('Body: ${response.body}');
  //   return Future<bool>.value(false);
  // } else {
  //   //print('Status code: ${response.statusCode}');
  //   throw Exception('Failed to create user.');
  // }
}

Future<Response> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://carletonsmartgarden.ca/api/users/login'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  //print('Status code: ${response.statusCode}');
  //print('Headers: ${response.headers}');
  //print('Body: ${response.body}');
  if (response.statusCode == 200) {
    var storage = const FlutterSecureStorage();
    var nodes = await getNode(email);

    // decode getNode Response body
    List<dynamic> decodedNodes = json.decode(nodes.body);
    String numberOfNodes = decodedNodes.length.toString();

    // write user email and all nodeID(s) returned along with number of Nodes to FlutterSecureStorage
    storage.write(key: "userEmail", value: email);
    storage.write(key: "numberOfNodes", value: numberOfNodes);
    for (int i = 0; i < decodedNodes.length; i++) {
      print(decodedNodes[i]);
      storage.write(key: "node${i}ID", value: decodedNodes[i]["nodeId"]);
    }

    return response;
  } else if (response.statusCode == 400) {
    print('Body: ${response.body}');
    // return Future<bool>.value(false);
    return response;
  } else {
    print('Status code: ${response.statusCode}');
    throw Exception('Failed to login.');
  }
}

Future<Response> getNode(String email) async {
  final queryParameters = {
    'email': email,
  };
  final uri = Uri.https(
      'www.carletonsmartgarden.ca', '/api/nodes/getnode', queryParameters);

  final response = await http.get(uri);
  //print('Status code: ${response.statusCode}');
  //print('Headers: ${response.headers}');
  //print('Body: ${response.body}');
  if (response.statusCode == 200) {
    // return Future<bool>.value(true);
    return response;
  } else if (response.statusCode == 400) {
    print('Body: ${response.body}');
    // return Future<bool>.value(false);
    return response;
  } else {
    print('Status code: ${response.statusCode}');
    throw Exception('Failed to get node data');
  }
}

Future<Response> getAllSensorData() async {
  var storage = const FlutterSecureStorage();
  var userEmail = await storage.read(key: "userEmail");

  Response response = await http
      .get(Uri.parse('https://carletonsmartgarden.ca/api/telemetry/get_all'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, the return response

    // print('Status code: ${response.statusCode}'); // PRINT TO CONSOLE TO DEBUG
    // print('Headers: ${response.headers}');
    // print('Body: ${response.body}');

    // inspect(response); USE THIS FOR DEBUGGER
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load all sensor data');
  }
}

Future<Response> getSensorData(String sensorType) async {
  final queryParameters = {
    'name': sensorType,
  };
  final uri = Uri.https('www.carletonsmartgarden.ca',
      '/api/telemetry/get_sensor_data', queryParameters);

  final response = await http.get(uri);

  // print('Status code: ${response.statusCode}'); // PRINT TO CONSOLE TO DEBUG
  // print('Headers: ${response.headers}');
  // print('Body: ${response.body}');

  // print('The type of response.body is ${response.body.runtimeType}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, return respone

    // inspect(response); USE THIS FOR DEBUGGER
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load $sensorType data');
  }
}

Future<Response> getNodeTelemetryData(String node) async {
  var storage = const FlutterSecureStorage();
  var email = await storage.read(key: "email");
  var nodeId = await storage.read(key: node);

  final queryParameters = {
    'email': email,
    'nodeId': nodeId,
  };
  final uri = Uri.https(
      'www.carletonsmartgarden.ca', '/api/telemetry/getdata', queryParameters);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to load $node data');
  }
}

Future<Response> getUserThresholds() async {
  var storage = const FlutterSecureStorage();

  final query = {
    'email': await storage.read(key: "userEmail"),
  };
  final uri = Uri.http(
      "www.carletonsmartgarden.ca", "/api/thresholds/getThreshold", query);
  return await http.get(uri, headers: {
    HttpHeaders.contentTypeHeader: "application/json",
  });
}

Future<Response> getUserNotifications() async {
  var storage = const FlutterSecureStorage();
  var userEmail = await storage.read(key: "userEmail");
  Map<String, String> query;

  if (userEmail != null) {
    query = {
      'email': userEmail,
    };
  } else {
    throw Exception('error with userEmail');
  }

  final uri = Uri.http("www.carletonsmartgarden.ca",
      "/api/notifications/getnotifications", query);
  return await http.get(uri);
}

Future deleteUserThresholds(String plantType, String sensor_name) async {
  var storage = const FlutterSecureStorage();
  var userEmail = await storage.read(key: "userEmail");
  Map<String, String> body;

  if (userEmail != null) {
    body = {
      'email': userEmail,
      'plantType': plantType,
      'sensor_name': sensor_name
    };
  } else {
    throw Exception("error with userEmail");
  }
  await http.delete(
    // retrieved from: cmd line -> ipconfig -> Ethernet adapter VirtualBox Host-Only Network:, IPv4
    Uri.parse(
        'https://www.carletonsmartgarden.ca/api/thresholds/deleteThreshold'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
}

Future<Response> postNewNode(String nodeId, String location) async {
  var storage = const FlutterSecureStorage();
  var userEmail = await storage.read(key: "userEmail");
  var numberOfNodes = await storage.read(key: "numberOfNodes");

  Map<String, String> body;

  if (userEmail != null) {
    body = {
      'nodeId': nodeId,
      'email': userEmail,
      'location': location,
    };
  } else {
    throw Exception("error with userEmail");
  }

  final response = await http.post(
    Uri.parse('https://www.carletonsmartgarden.ca/api/nodes/createnode'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, return respone

    // inspect(response); USE THIS FOR DEBUGGER
    var storage = const FlutterSecureStorage();
    int newNodeNumber = (numberOfNodes as int) + 1;
    storage.write(key: "node$newNodeNumber", value: nodeId);
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to post new node data');
  }
}

Future<Response> postTelemetryData(String nodeId, String plantType,
    String sensorType, String min, String max) async {
  var storage = const FlutterSecureStorage();
  var userEmail = await storage.read(key: "userEmail");
  Map<String, String> body;

  if (userEmail != null) {
    body = {
      'nodeId': nodeId,
      'email': userEmail,
      'plantType': plantType,
      'sensor_name': sensorType,
      'min': min,
      'max': max
    };
  } else {
    throw Exception("error with userEmail");
  }

  final response = await http.post(
    Uri.parse('https://www.carletonsmartgarden.ca/api/thresholds/addThreshold'),
    headers: <String, String>{
      'Content-type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  return response;
}

///////////////////////////////////////////////////////////
// ------------- METHOD'S TO DECODE DATA --------------- //
///////////////////////////////////////////////////////////

/// make sure response is NOT NULL, or else this will return nothing
String decodeGetAllData(Response? response) {
  String decodedData = "";
  List<NodeDataSeries> dataList = [];
  // NodeDataSeries(
  //   "2022-01-03T20:54:57",
  //   25,
  //   // charts.ColorUtil.fromDartColor(Colors.green),
  // ),
  // ];

  if (response != null) {
    List<dynamic> data = json.decode(response.body);

    data.forEach((dataEntry) {
      String sensorName = dataEntry["sensor_name"];
      String timeStamp = dataEntry["timestamp"];
      int value = dataEntry["value"].round();

      decodedData +=
          "sensor name: $sensorName, time stamp: $timeStamp, value: $value\n\n";
    });
  }

  return decodedData;
}

/// make sure response is NOT NULL, or else this will return nothing
String decodeGetAllDataIntoChart(Response? response) {
  String decodedData = "";
  if (response != null) {
    List<dynamic> data = json.decode(response.body);

    data.forEach((dataEntry) {
      // String _id = dataEntry["_id"];
      String sensorName = dataEntry["sensor_name"];
      String timeStamp = dataEntry["timestamp"];
      int value = dataEntry["value"].round();

      decodedData +=
          "sensor name: $sensorName, time stamp: $timeStamp, value: $value\n\n";
    });
  }

  return decodedData;
}

// TODO: fix this nastiness
/// make sure response is NOT NULL, or else this will return nothing
Map<String, Map<String, Object>> /*String*/ decodeLatestData(
    Response? response, BuildContext context) {
  Map<String, Map<String, Object>> decodedData = {
    "humidity": {
      "time": "",
      "value": 0,
    },
    "temperature": {
      "time": "",
      "value": 0,
    },
    "soil moisture": {
      "time": "",
      "value": 0,
    }
  };

  int humiditySensorTimeInSeconds = 0,
      temperatureSensorTimeInSeconds = 0,
      soilMoistureSensorTimeInSeconds = 0;

  if (response != null && response.body.length > 1) {
    List<dynamic> data = json.decode(response.body);
    int currentTimeStampInSeconds;

    for (var dataEntry in data) {
      currentTimeStampInSeconds =
          getSecondsFromAwsTimeStamp(dataEntry["timestamp"]);

      switch (dataEntry["sensor_name"]) {
        case "humidity":
          {
            if (currentTimeStampInSeconds > humiditySensorTimeInSeconds) {
              humiditySensorTimeInSeconds = currentTimeStampInSeconds;
              decodedData["humidity"]!["time"] = dataEntry["timestamp"];
              decodedData["humidity"]!["value"] = dataEntry["value"].round();
            }
          }
          break;
        case "temperature":
          {
            if (currentTimeStampInSeconds > temperatureSensorTimeInSeconds) {
              temperatureSensorTimeInSeconds = currentTimeStampInSeconds;
              decodedData["temperature"]!["time"] = dataEntry["timestamp"];
              decodedData["temperature"]!["value"] = dataEntry["value"].round();
            }
          }
          break;
        case "soil_moisture":
          {
            if (currentTimeStampInSeconds > soilMoistureSensorTimeInSeconds) {
              soilMoistureSensorTimeInSeconds = currentTimeStampInSeconds;
              decodedData["soil moisture"]!["time"] = dataEntry["timestamp"];
              decodedData["soil moisture"]!["value"] =
                  dataEntry["value"].round();
            }
          }
          break;
        default:
          {}
      }
    }
  } else {
    return {};
  }
  return decodedData;
}

int getSecondsFromAwsTimeStamp(String date) {
  String year, month, day, hour, minutes, seconds = "";
  year = date.substring(0, 4);
  month = date.substring(5, 7);
  day = date.substring(8, 10);
  hour = date.substring(11, 13);
  minutes = date.substring(14, 16);
  seconds = date.substring(17, 19);

  return int.parse(year) * 31540000 +
      int.parse(month) * 2628288 +
      int.parse(day) * 86400 +
      int.parse(hour) * 3600 +
      int.parse(minutes) * 60 +
      int.parse(seconds);
}
