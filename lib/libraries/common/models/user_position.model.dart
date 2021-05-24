import 'dart:convert';

import 'package:desafio_toro/libraries/common/models/position.model.dart';

class UserPositionModel {
  UserPositionModel({
    required this.checkingAccountAmount,
    required this.positions,
    required this.consolidated,
  });

  final double checkingAccountAmount;
  final List<PositionModel> positions;
  final double consolidated;

  factory UserPositionModel.fromJson(String str) =>
      UserPositionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserPositionModel.fromMap(Map<String, dynamic> json) =>
      UserPositionModel(
        checkingAccountAmount: json["checkingAccountAmount"],
        positions: List<PositionModel>.from(
            json["positions"].map((x) => PositionModel.fromMap(x))),
        consolidated: json["consolidated"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "checkingAccountAmount": checkingAccountAmount,
        "positions": List<dynamic>.from(positions.map((x) => x.toMap())),
        "consolidated": consolidated,
      };
}
