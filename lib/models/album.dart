
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