import 'package:horno/models/index.dart';
import 'dart:convert';

class OrderModel {
  OrderModel({
    this.id,
    this.createdAt,
    required this.clientId,
    required this.localId,
    required this.state,
    required this.paymentMethod,
    required this.total,
    this.orderCode,
    this.details,
  });

  int? id;
  DateTime? createdAt;
  String clientId;
  int localId;
  String state;
  String paymentMethod;
  double total;
  String? orderCode;
  List<DetailModel>? details;

  factory OrderModel.fromJson(String str) =>
      OrderModel.fromMap(json.decode(str));

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        clientId: json["client_id"],
        localId: json["local_id"],
        state: json["state"],
        paymentMethod: json["payment_method"],
        total: json["total"],
        orderCode: json["order_code"],
        details: List<DetailModel>.from(
            json["details"].map((x) => DetailModel.fromJson(x))),
      );

  factory OrderModel.fromMapSave(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        clientId: json["client_id"],
        localId: json["local_id"],
        state: json["state"],
        paymentMethod: json["payment_method"],
        total: json["total"],
        orderCode: json["order_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "client_id": clientId,
        "local_id": localId,
        "state": state,
        "payment_method": paymentMethod,
        "total": total,
        "order_code": orderCode,
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toJsonSave() => {
        "client_id": clientId,
        "local_id": localId,
        "state": state,
        "payment_method": paymentMethod,
        "total": total,
      };

  String toRawJson() => json.encode(toJsonSave());
}
