import 'package:flutter/material.dart';
import 'package:fetch_data_internet/services/network.dart';
import '../models/album.dart';

// Based on https://flutter.dev/docs/cookbook/networking/fetch-data
// 1. Add the http package

// 2. Make a network request
// Fetch a sample album from the JSONPlaceholder using the http.get() method.

// 3. Convert the response into a custom Dart object
// 3.1 - Create an Album class
// 3.2 - Convert the http.Response to an Album

// 4. Fetch the data

// 5. Display the data - use FutureBuilder

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
    futureAlbum = NetworkService().fetchAlbum();
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
