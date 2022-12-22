import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

import 'package:horno/widgets/textwidget2.dart';

import '../../theme/theme.dart';

class ProteccionScreen extends StatelessWidget {
  const ProteccionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Definir ancho-width y largo-height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    //
    return Scaffold(
      appBar: AppBar(
        title: Text('TechMovilSystem',
            style: TextStyle(
                color: ColorsApp.colorLight,
                fontWeight: FontWeight.bold,
                fontSize: 26)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsApp.colorPrimary,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: Medidas.mypadding,
            right: Medidas.mypadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 70,
                height: 70,
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/loading.gif"),
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/12/10/16/39/shield-1086702_960_720.png'),
                ),
              ),
              const TitleWidget('Protección'),
              Container(
                width: screenWidth,
                height: screenHeight * 0.5,
                child: const SingleChildScrollView(
                  child: TextWidget2(
                      text:
                          'A los efectos de asegurar que su tarjeta de crédito, débito o cargo no sea utilizada sin su consentimiento, validaremos el nombre, la dirección y otra información personal que usted nos facilite durante el proceso de pedido verificándola y comprobándola con bases de datos de terceros. Dado el volumen de fraude con tarjetas de crédito, nosotros tomamos todas las medidas necesarias para asegurarnos de que todos los pedidos son minuciosamente revisados usando la información facilitada por usted.'),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        context: context,
        currentIndex: -1,
      ),
    );
  }
}
