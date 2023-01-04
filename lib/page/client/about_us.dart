import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final launcherProvider = Provider.of<LauncherProvider>(context);
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
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/whatsapp.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: ColorsApp.colorPrimary,
                          )),
                    ),
                    onPressed: () => launcherProvider.goWhatsappLauncher(),
                  ),
                  MaterialButton(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/facebook2.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: ColorsApp.colorPrimary,
                          )),
                    ),
                    onPressed: () => launcherProvider.goFacebook(),
                  ),
                  MaterialButton(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/instagram.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: ColorsApp.colorPrimary,
                          )),
                    ),
                    onPressed: () => launcherProvider.goInstagram(),
                  ),
                  MaterialButton(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/tiktok.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: ColorsApp.colorPrimary,
                          )),
                    ),
                    onPressed: () => launcherProvider.goInstagram(),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
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

// _enviarMensajeWhatsapp() async {
//   var numero = "+51902870396";
//   var cadena = Uri.parse("whatsapp://send?$numero&text=hola");
//   if (await canLaunchUrl(cadena)) {
//     await launchUrl(cadena);
//   } else {
//     // ScaffoldMessenger.of(context)
//     //     .showSnackBar(const SnackBar(content: Text('data')));
//   }
// }

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
