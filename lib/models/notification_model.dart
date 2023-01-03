class NotificationModel {
  final int orderId;
  final String state;
  final String userId;
  final String message;
  final String orderText;

  NotificationModel({
    required this.orderId,
    required this.state,
    required this.userId,
    required this.message,
    required this.orderText,
  });

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "state": state,
        "user_id": userId,
        "message": message,
        "order_text": orderText,
      };
}
