import 'dart:convert';

import 'package:timeago/timeago.dart' as timeago;

class MyNotificationModel {
  MyNotificationModel({
    required this.id,
    required this.createdAt,
    required this.orderId,
    required this.state,
    required this.userId,
    required this.message,
    required this.orderText,
  });

  int id;
  DateTime createdAt;
  int orderId;
  String state;
  String userId;
  String message;
  String orderText;

  factory MyNotificationModel.fromRawJson(String str) =>
      MyNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyNotificationModel.fromJson(Map<String, dynamic> json) =>
      MyNotificationModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        orderId: json["order_id"],
        state: json["state"],
        userId: json["user_id"],
        message: json["message"],
        orderText: json["order_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "order_id": orderId,
        "state": state,
        "user_id": userId,
        "message": message,
        "order_text": orderText,
      };

  String get orderIdText {
    if (orderId == null) {
      return "00000";
    }

    return orderId.toString().padLeft(5, '0');
  }

  StateNotify get evaluateState {
    if (message.isEmpty) {
      return StateNotify.notMessage;
    }

    if (message.toLowerCase().contains('insumo')) {
      return StateNotify.received;
    } else if (message.toLowerCase().contains('horneandose')) {
      return StateNotify.notify;
    } else {
      return StateNotify.completed;
    }
  }

  String get activityText {
    if (message.isEmpty) {
      return 'procesandose';
    }

    if (message.toLowerCase().contains('insumo')) {
      return 'recibida';
    } else if (message.toLowerCase().contains('horneandose')) {
      return 'horneandose';
    } else {
      return 'completado';
    }
  }

  String get timeText {
    return timeago.format(createdAt, locale: 'es');
  }
}

enum StateNotify { completed, notify, received, notMessage }
