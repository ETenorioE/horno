import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

import '../widgets/title_widget.dart';

class TypeRolPage extends StatelessWidget {
  const TypeRolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleWidget('Iniciar sesión como'),
          Row(
            children: [
              Container(
                child: TextWidget('Cliente'),
              ),
              Container(
                child: TextWidget('Socio'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
