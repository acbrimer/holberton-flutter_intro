class Character {
  late String name;
  late String imgUrl;
  late int id;

  Character({required Map<dynamic, dynamic> json}) {
    name = json['name'];
    imgUrl = json['img'];
    id = json['char_id'];
  }
}
