import 'package:flutter/material.dart';
import 'package:horno/models/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum TypeMessage { ingredient, bake, completed }

class ProcessService extends ChangeNotifier {
  int? _orderId;
  int _stages = 0;
  int _stagesCompleted = 0;
  String? _userId;
  String state = 'Pendiente';

  set orderId(int orderId) {
    _orderId = orderId;
    notifyListeners();
  }

  set stagesCompleted(int stages) {
    _stagesCompleted = stages;
    notifyListeners();
  }

  Future<OrderModel> findById() async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('orders')
        .select('*,details(*)')
        .eq('id', _orderId)
        .single();

    final orderSave = OrderModel.fromMap(response);

    final itemCount = orderSave.details?.length;

    _stages = (itemCount! + 1);

    _userId = orderSave.clientId;

    return orderSave;
  }

  String makeStateText({required TypeMessage type}) {
    switch (type) {
      case TypeMessage.ingredient:
        return 'Iniciando';
      case TypeMessage.bake:
        return 'Horneando';
      case TypeMessage.completed:
        return 'Completado';
      default:
        return 'Pendiente';
    }
  }

  String makeMessageText({
    required TypeMessage type,
    required int stage,
    required int stageCompleted,
  }) {
    String text = '';

    switch (type) {
      case TypeMessage.ingredient:
        text = 'Insumo recibido del pedido';
        break;
      case TypeMessage.bake:
        int itemsCount = stage - 1;
        int itemsCompleted = stageCompleted - 1;
        text = '$itemsCompleted/$itemsCount horneandose del pedido';
        break;
      case TypeMessage.completed:
        text = 'Listo para recoger el pedido';
        break;
    }

    return text;
  }

  Future<String?> saveProcess({
    required TypeMessage type,
    required bool isConfirmed,
  }) async {
    if (isConfirmed && type == TypeMessage.completed) return null;

    if (_orderId == null) return null;

    if (_userId == null) return null;

    final supabase = Supabase.instance.client;

    final state = makeStateText(type: type);

    await supabase.from('orders').update({
      'state': state,
      'stages': _stagesCompleted,
    }).eq('id', _orderId);

    final orderText = _orderId.toString().padLeft(5, '0');

    final messageText = makeMessageText(
      type: type,
      stage: _stages,
      stageCompleted: _stagesCompleted,
    );

    final notification = NotificationModel(
        orderId: _orderId!,
        state: 'no leido',
        userId: _userId!,
        message: "$messageText #$orderText",
        orderText: orderText);

    await supabase.from('notifications').insert(notification.toJson());

    if (type == TypeMessage.completed) {
      this.state = state;
      notifyListeners();
    }

    return 'Notificación enviada';
  }
}
