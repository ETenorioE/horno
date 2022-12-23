import 'package:horno/database/index.dart';

class OrderDbModel {
  int? id;
  String? clientId;
  int? localId;

  OrderDbModel({this.id, this.clientId, this.localId});

  OrderDbModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    clientId = map["clientId"];
    localId = map["localId"];
  }

  Map<String, dynamic> toMap() {
    return {
      DBOrders.columnId: id,
      DBOrders.columnClientId: clientId,
      DBOrders.columnLocalId: localId,
    };
  }
}
