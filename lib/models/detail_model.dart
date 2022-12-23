class DetailModel {
  DetailModel({
    required this.id,
    required this.createdAt,
    required this.orderId,
    required this.serviceName,
    required this.serviceImage,
    required this.servicePrice,
    required this.weight,
    required this.total,
  });

  int id;
  DateTime createdAt;
  int orderId;
  String serviceName;
  String serviceImage;
  int servicePrice;
  int weight;
  int total;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        orderId: json["order_id"],
        serviceName: json["service_name"],
        serviceImage: json["service_image"],
        servicePrice: json["service_price"],
        weight: json["weight"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "order_id": orderId,
        "service_name": serviceName,
        "service_image": serviceImage,
        "service_price": servicePrice,
        "weight": weight,
        "total": total,
      };
}
