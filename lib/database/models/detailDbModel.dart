import 'package:horno/database/index.dart';

class DetailDbModel {
  int? id;
  int? orderId;
  int? serviceId;
  String? serviceName;
  String? serviceImage;
  double? servicePrice;
  int? weight;
  double? total;

  DetailDbModel({
    this.serviceId,
    this.serviceName,
    this.serviceImage,
    this.servicePrice,
    this.weight,
    this.total,
    this.id,
    this.orderId,
  });

  DetailDbModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    orderId = map["orderId"];
    serviceId = map["serviceId"];
    serviceName = map["serviceName"];
    serviceImage = map["serviceImage"];
    servicePrice = map["servicePrice"];
    weight = map["weight"];
    total = map["total"];
  }

  Map<String, dynamic> toMap() {
    return {
      DBDetails.columnId: id,
      DBDetails.columnOrderId: orderId,
      DBDetails.columnServiceId: serviceId,
      DBDetails.columnServiceName: serviceName,
      DBDetails.columnServiceImage: serviceImage,
      DBDetails.columnServicePrice: servicePrice,
      DBDetails.columnTotal: total,
      DBDetails.columnWeight: weight,
    };
  }
}
