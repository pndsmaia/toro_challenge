import 'dart:convert';

import 'package:desafio_toro/libraries/common/models/user_position.model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.userPosition,
  });

  String id;
  String name;
  String cpf;
  String email;
  UserPositionModel userPosition;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        cpf: json["cpf"],
        email: json["email"],
        userPosition: UserPositionModel.fromMap(json["userPosition"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "cpf": cpf,
        "email": email,
        "userPosition": userPosition.toMap(),
      };
}
