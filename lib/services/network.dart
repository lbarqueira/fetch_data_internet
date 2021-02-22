import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fetch_data_internet/models/album.dart';

const String jsonPlaceholderURL =
    'https://jsonplaceholder.typicode.com/albums/1';

class NetworkService {
  Future<Album> fetchAlbum() async {
    final response = await http
        .get(jsonPlaceholderURL); //returns a Future that contains a Response

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
}
