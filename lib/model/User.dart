import 'package:newflutterapp/utils/Utils.dart';

class User {
  int id;
  String name;
  String phone;
  String email;
  int favorite;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnPhone: phone,
      columnEmail: email,
      columnFavorite: favorite
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    phone = map[columnPhone];
    email = map[columnEmail];
    favorite = map[columnFavorite];
  }
}
