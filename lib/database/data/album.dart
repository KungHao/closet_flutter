class Album {
  final int? id;
  final String albumName;
  final int imageId;

  Album({this.id, required this.albumName, required this.imageId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'albumName': albumName, 'imageId': imageId};
  }
}
