import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horno/widgets/index.dart';

class VoucherPage extends StatelessWidget with RenderPage {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarRender(title: 'Subir comprobante de pago'),
    );
  }
}
