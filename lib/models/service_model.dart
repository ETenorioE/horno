class ServiceModel {
  ServiceModel({
    required this.id,
    required this.createdAt,
    required this.serviceId,
    required this.localId,
    required this.name,
    required this.price,
    required this.image,
  });

  int id;
  DateTime createdAt;
  int serviceId;
  int localId;
  String name;
  String image;
  double price;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        serviceId: json["service_id"],
        localId: json["local_id"],
        name: json["name"],
        image: json["image"],
        price: double.tryParse(json["price"].toString())!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "service_id": serviceId,
        "local_id": localId,
        "name": name,
        "image": image,
        "price": price,
      };
}
