import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class ProtectionPage extends StatelessWidget with RenderPage {
  const ProtectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'TechMovilSystem'),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: MeasuresApp.myPadding,
              right: MeasuresApp.myPadding,
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
      ),
    );
  }
}
