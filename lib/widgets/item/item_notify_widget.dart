import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/models/index.dart';
import 'package:horno/widgets/index.dart';

class ItemNotify extends StatelessWidget {
  final StateNotify state;
  final String order;
  final String client;
  final String? activity;
  final String time;

  String _message = "";
  String _asset = "assets/notify";

  ItemNotify({
    Key? key,
    required this.state,
    required this.order,
    required this.client,
    this.activity = "horneandose",
    required this.time,
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
          Expanded(
            child: Container(
              width: 325,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: ColorsApp.colorText))),
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Buenas tardes,',
                          style: _styleText(),
                          children: [
                        TextSpan(text: " $client ", style: _styletTitle()),
                        const TextSpan(text: 'su pedido de la orden'),
                        TextSpan(text: " #$order ", style: _styletTitle()),
                        TextSpan(text: ", se encuentra $activity")
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextWidget(
                        time,
                        fontSize: 14,
                        color: ColorsApp.colorTitle,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _styleText() {
    return GoogleFonts.openSans(
        fontSize: 16, color: ColorsApp.colorText, fontWeight: FontWeight.bold);
  }

  TextStyle _styletTitle() {
    return GoogleFonts.openSans(
        color: ColorsApp.colorTitle, fontSize: 16, fontWeight: FontWeight.bold);
  }
}
