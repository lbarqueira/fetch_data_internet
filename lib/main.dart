import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Base on https://flutter.dev/docs/cookbook/networking/fetch-data
// 1. Add the http package

// 2. Make a network request
// Fetch a sample album from the JSONPlaceholder using the http.get() method.

// 3. Convert the response into a custom Dart object
// 3.1 - Create an Album class
// 3.2 - Convert the http.Response to an Album

// 4. Fetch the data

// 5. Display the data - use FutureBuilder

Future<Album> fetchAlbum() async {
  final response = await http.get(
      'https://jsonplaceholder.typicode.com/albums/1'); //returns a Future that contains a Response

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    print(json.decode(response.body));
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// model - Create a Album class that contains the data from the network request.
class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  // factory Album.fromJson(Map<String, dynamic> json) {
  //   return Album(
  //     userId: json['userId'],
  //     id: json['id'],
  //     title: json['title'],
  //   );

  Album.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int,
        id = json['id'] as int,
        title = json['title'] as String;
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          // To display the data on screen, use the FutureBuilder widget.
          // The FutureBuilder widget comes with Flutter and makes it easy
          // to work with asynchronous data sources.
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data.title),
                    Text(snapshot.data.id.toString()),
                    Text(snapshot.data.userId.toString()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
