import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class SoftwarePage extends StatelessWidget with RenderPage {
  const SoftwarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ThemeCustomWidget(
      child: Scaffold(
        appBar: appBarRender(title: 'TechMovilSystem'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
              const TitleWidget('Software'),
              SizedBox(
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
        ),
        bottomNavigationBar: BottomNavigationWidget(
          context: context,
          currentIndex: -1,
        ),
      ),
    );
  }
}
