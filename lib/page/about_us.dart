import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/theme/theme.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de Nosotros',
            style: TextStyle(
                color: ColorsApp.colorLight,
                fontWeight: FontWeight.bold,
                fontSize: 26)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsApp.colorPrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [
              _ListTileCustom(
                Titulo: 'Términos y Condiciones',
                onTap: TerminosScreen(),
              ),
              _ListTileCustom(
                Titulo: 'Políticas de Privacidad',
                onTap: PoliticasScreen(),
              ),
              _ListTileCustom(
                Titulo: 'Protección',
                onTap: ProteccionScreen(),
              ),
              _ListTileCustom(
                Titulo: 'Software',
                onTap: SoftwareScreen(),
              ),
              //================
            ],
          ),
          Column(
            children: [
              Text(
                'Siguenos en :',
                style: TextStyle(
                    color: ColorsApp.colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.home),
                  Icon(Icons.home),
                  Icon(Icons.home),
                  Icon(Icons.home),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListTileCustom extends StatelessWidget {
  final String Titulo;
  final Widget onTap;

  const _ListTileCustom({super.key, required this.Titulo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Titulo,
        style: TextStyle(
            color: ColorsApp.colorTitle,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      trailing: const Icon(Icons.arrow_right_alt_rounded, size: 50),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => onTap));
      },
    );
  }
}
