import 'package:flutter/material.dart';
import '../../widgets/index.dart';

class PoliticasScreen extends StatelessWidget {
  const PoliticasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //DEFINIR EL ANCHO(WIDTH) Y LARGO(HEIGHT) DE LA PANTALLA
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TechMovilSystem',
          style: TextStyle(
              color: ColorsApp.colorLight,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
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
                height: 70,
                width: 70,
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/loading.gif"),
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/03/31/14/48/sheet-1292828_960_720.png'),
                ),
              ),
              const TitleWidget('Politicas de Privacidad'),
              Container(
                height: screenHeight * 0.5,
                // width: double.infinity,
                width: screenWidth,

                child: const SingleChildScrollView(
                  child: TextWidget2(
                    text:
                        'A los efectos de asegurar que su tarjeta de crédito, débito o cargo no sea utilizada sin su consentimiento, validaremos el nombre, la dirección y otra información personal que usted nos facilite durante el proceso de pedido verificándola y comprobándola con bases de datos de terceros. Dado el volumen de fraude con tarjetas de crédito, nosotros tomamos todas las medidas necesarias para asegurarnos de que todos los pedidos son minuciosamente revisados usando la información facilitada por usted.',
                  ),
                ),
              ),
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
