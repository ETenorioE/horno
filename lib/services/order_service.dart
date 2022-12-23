import 'dart:math';
import 'package:flutter/material.dart';
import 'package:horno/database/index.dart';
import 'package:horno/models/index.dart';

class OrderService extends ChangeNotifier {
  List<DetailDbModel> details = [];
  OrderDbModel? order;
  double total = 0;
  String paymentMethod = 'visa';

  Future createOrder(ServiceModel service, String? client) async {
    order = await DBOrders.findByLocal(service.localId);

    if (order == null) {
      order = OrderDbModel(
        clientId: client,
        localId: service.localId,
      );

      order?.id = await DBOrders.save(order!);
    }

    final detail = DetailDbModel(
      orderId: order!.id,
      serviceId: service.id,
      serviceName: service.name,
      serviceImage: service.image,
      servicePrice: service.price,
      weight: 1,
      total: 1 * service.price,
    );

    await DBDetails.save(detail);

    await _getDetails(order!.id!);
  }

  Future _getDetails(int order) async {
    final items = await DBDetails.getAllByOrder(order);

    details = items;

    final orderTotal =
        items.fold<double>(0, (sum, element) => sum + element.total!);

    total = orderTotal;

    notifyListeners();
  }

  Future updateDetail(
    int id, {
    required int weight,
    required double total,
  }) async {
    DetailDbModel? detail = await DBDetails.findById(id);

    if (detail == null) return;

    detail.weight = weight;
    detail.total = total;

    await DBDetails.update(detail);

    await _getDetails(detail.orderId!);
  }

  Future deleteDetail(int id) async {
    await DBDetails.deleteById(id);

    await _getDetails(order!.id!);
  }

  void setPaymentMethod(String value) {
    paymentMethod = value;
    notifyListeners();
  }

  Future clearData() async {
    await DBOrders.deleteRows(order!);

    order = null;
    total = 0;
    details = [];

    notifyListeners();
  }
}
