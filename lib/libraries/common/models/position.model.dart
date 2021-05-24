import 'dart:convert';

class PositionModel {
  PositionModel({
    required this.symbol,
    required this.amount,
    required this.currentPrice,
  });

  final String symbol;
  final int amount;
  final double currentPrice;

  factory PositionModel.fromJson(String str) =>
      PositionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PositionModel.fromMap(Map<String, dynamic> json) => PositionModel(
        symbol: json["symbol"],
        amount: json["amount"],
        currentPrice: json["currentPrice"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "symbol": symbol,
        "amount": amount,
        "currentPrice": currentPrice,
      };
}
