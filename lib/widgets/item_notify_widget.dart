import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

enum StateNotify { completed, notify }

class ItemNotify extends StatelessWidget {
  final StateNotify state;
  final String order;
  final String client;
  final String? activity;

  String _message = "";
  String _asset = "assets/notify";

  ItemNotify({
    Key? key,
    required this.state,
    required this.order,
    required this.client,
    this.activity = "horneandose",
  }) : super(key: key) {
    process();
  }

  void process() {
    switch (state) {
      case StateNotify.notify:
        _message = activity!;
        _asset = "$_asset/notify.png";
        break;
      case StateNotify.completed:
        _message = "completada";
        _asset = "$_asset/completed.png";
        break;
      default:
        _message = "";
        _asset = "assets/notify/notify.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 36),
            child: Image.asset(_asset),
          ),
          Container(
            width: 325,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: ColorsApp.colorText))),
            padding: const EdgeInsets.only(right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TextWidget('Buenas tardes'),
                    const SpaceWidth(10),
                    TextWidget(
                      client,
                      color: ColorsApp.colorTitle,
                    )
                  ],
                ),
                Row(
                  children: [
                    const TextWidget('su pedido de la orden'),
                    const SpaceWidth(10),
                    TextWidget(
                      "#$order",
                      color: ColorsApp.colorTitle,
                    )
                  ],
                ),
                TextWidget('Se encuentra $_message'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidget(
                      'hace 3min',
                      fontSize: 14,
                      color: ColorsApp.colorTitle,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
