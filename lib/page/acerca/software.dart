import 'package:flutter/material.dart';
import '../../widgets/index.dart';

class SoftwareScreen extends StatelessWidget {
  const SoftwareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //DEFINIR EL ANCHO(WIDTH) Y LARGO(HEIGHT) DE LA PANTALLA
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 70,
            width: 70,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/loading.gif"),
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2016/01/10/22/30/smartphone-1132675_960_720.png'),
            ),
          ),
          const TitleWidget('Softwware'),
          Container(
            height: screenHeight * 0.5,
            // width: double.infinity,
            width: screenWidth,

            child: const SingleChildScrollView(
              child: TextWidget2(
                text:
                    'BakeApp es un aplicativo movil desarrollado por la empresa TechMovilSystem, para el beneficio de toda la poblacion de Ayacuho y empresas que se dedican al rubro de los Hornos, en esta version 1.0, mostraremos todos los hornos disponibles y cercanos a su ubicacion, notificaremos el estado de su pedido.',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        context: context,
        currentIndex: -1,
      ),
    );
  }
}
