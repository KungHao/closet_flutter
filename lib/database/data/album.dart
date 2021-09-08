class Album {
  int? id;
  String albumName;

  Album({this.id, required this.albumName});

  Map<String, dynamic> toMap() {
    return {'id': id, 'albumName': albumName};
  }

  void fromMap(Map<String, dynamic> map) {
    id = map['id'];
    albumName = map['albumName'];
  }

}
