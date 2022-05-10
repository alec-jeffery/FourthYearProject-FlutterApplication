# app

IoT for Smart Urban Farming and Gardening Flutter app.

## Getting Started

A few resources to get you started if this is your first Flutter app:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Important Notes on Our App

### FlutterSecureStorage (FSS)

FlutterSecureStorage securely saves data on the app, where one is able to access it throughout.
To save a value:
```
    var storage = const FlutterSecureStorage();
    storage.write(key: "userEmail", value: email);
```

To access a saved value (NOTE: storage.read() is an asyncronous call, so use it asyncronously - use it in an async function for example)
```
    var storage = const FlutterSecureStorage();
    var userEmail = await storage.read(key: "userEmail");
```

### FSS Keys

#### email

#### numberOfNodes
Number of nodes that a user has

#### node1ID, node2ID, ...
Generated keys for all nodes along with their nodeId according to the numberOfNodes a user has
