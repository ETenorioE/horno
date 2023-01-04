import 'package:horno/models/index.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

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
    this.stages,
  });

  int? id;
  DateTime? createdAt;
  String clientId;
  int localId;
  String state;
  String paymentMethod;
  double total;
  String? orderCode;
  int? stages;
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
        stages: json["stages"],
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
        stages: json["stages"],
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
        "stages": stages,
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toJsonSave() => {
        "client_id": clientId,
        "local_id": localId,
        "state": state,
        "payment_method": paymentMethod,
        "stages": stages,
        "total": total,
      };

  String toRawJson() => json.encode(toJsonSave());

  String get totalText => "S/. ${total.toStringAsFixed(2)}";

  String get orderText {
    if (id == null) {
      return "00000";
    }

    return id.toString().padLeft(5, '0');
  }

  String get createdText {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(createdAt!);
    return formatted;
  }

  String get timeText {
    return timeago.format(createdAt!, locale: 'es');
  }
}
