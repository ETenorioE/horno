import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyOrdersService {
  static Future<List<OrderModel>> findByLocal(int local) async {
    final supabase = Supabase.instance.client;
    List<OrderModel> list = [];

    final List<dynamic> response = await supabase
        .from('orders')
        .select('*')
        .eq('local_id', local)
        .order('id', ascending: false);

    for (var item in response) {
      final order = OrderModel.fromMapSave(item);

      list.add(order);
    }

    return list;
  }
}
