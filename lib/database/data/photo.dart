class Photo {
  int? id;
  String? albumName;
  String? photo;

  Photo({this.id,required this.albumName, required this.photo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'albumName': albumName, 'photo': photo};
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    albumName = map['albumName'];
    photo = map['photo'];
  }

}
