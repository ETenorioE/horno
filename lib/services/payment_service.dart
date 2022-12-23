import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/database/index.dart';
import 'package:horno/models/index.dart';
import 'package:horno/services/base.dart';
import 'package:horno/widgets/index.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

enum StateProcess { success, error }

class StateMessageProcess {
  final StateProcess state;
  final String msg;

  StateMessageProcess({required this.state, required this.msg});
}

class PaymentService extends ChangeNotifier {
  int orderId = 38;

  final String baseUrl = "${BaseService.baseURL}/orders";

  Future<StateMessageProcess> save({
    required OrderDbModel order,
    required List<DetailDbModel> details,
    required String paymentMethod,
    required double total,
  }) async {
    final supabase = Supabase.instance.client;

    EasyLoading.instance.backgroundColor = ColorsApp.colorSecondary;

    EasyLoading.show(status: 'Procesando...');

    try {
      final data = OrderModel(
          clientId: order.clientId!,
          localId: order.localId!,
          state: 'wait',
          paymentMethod: paymentMethod,
          total: total);

      int orderId = await _saveOrder(supabase, data);

      final detailsMap = _convertDetails(details, orderId);

      await supabase.from('details').insert(detailsMap);

      String orderText = orderId.toString().padLeft(5, '0');

      this.orderId = orderId;

      notifyListeners();
      // EasyLoading.dismiss();

      return StateMessageProcess(
        state: StateProcess.success,
        msg: "Pedido #$orderText registrado",
      );
    } on Exception catch (e) {
      print(e);
      // EasyLoading.dismiss();

      return StateMessageProcess(
        state: StateProcess.error,
        msg: 'No se pudo completar la orden',
      );
    }
  }

  Future<OrderModel> findById(int id) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('orders')
        .select('*,details(*)')
        .eq('id', id)
        .single();

    final orderSave = OrderModel.fromMap(response);

    return orderSave;
  }

  Future<List<OrderModel>> findAll() async {
    final supabase = Supabase.instance.client;
    List<OrderModel> list = [];

    final List<dynamic> response =
        await supabase.from('orders').select('*').order('id', ascending: false);

    for (var item in response) {
      final order = OrderModel.fromMapSave(item);

      list.add(order);
    }

    return list;
  }

  List<Map<String, dynamic>> _convertDetails(
      List<DetailDbModel> details, int orderId) {
    return details
        .map((e) => DetailModel(
                orderId: orderId,
                serviceName: e.serviceName!,
                serviceImage: e.serviceImage!,
                servicePrice: e.servicePrice!,
                weight: e.weight!,
                total: e.total!)
            .toJsonSave())
        .toList();
  }

  Future<int> _saveOrder(SupabaseClient supabase, OrderModel order) async {
    final response = await supabase
        .from('orders')
        .insert(order.toJsonSave())
        .select()
        .single();

    final orderSave = OrderModel.fromMapSave(response);

    return orderSave.id!;
  }
}
