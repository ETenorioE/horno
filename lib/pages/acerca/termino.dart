import 'package:flutter/material.dart';
import 'package:horno/widgets/index.dart';

class TerminosScreen extends StatelessWidget {
  const TerminosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Definir width and height
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWigth = MediaQuery.of(context).size.width;
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
                      'https://cdn.pixabay.com/photo/2017/01/31/11/48/checklist-2023731_960_720.png'),
                ),
              ),
              const TitleWidget('Terminos y Condiciones'),
              Container(
                height: screenHeight * 0.5,
                width: screenWigth,
                child: const SingleChildScrollView(
                  child: TextWidget2(
                    text:
                        'Como condición para el acceso y uso del aplicativo o Servicios, usted acepta que cumplirá con toda la legislación y las normativas aplicables al acceder o usar el aplicativo o Servicios. Usted acepta que no copiará, reproducirá, descargará, volverá a publicar, venderá, distribuirá o revenderá ningún Servicio ni ninguna información, texto, imágenes, gráficos, clips de vídeo, sonido, directorios, archivos, bases de datos o listados, etc.',
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
