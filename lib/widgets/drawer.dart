import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/widgets/index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: TitleWidget('Eduardo Tenorio'),
              ),
            ),
            ListTileCustom(
              icon: Icons.home_filled,
              texto: 'Inicio',
              color: ColorsApp.colorTitle,
              ontap: const LocalsPage(),
            ),
            ListTileCustom(
              icon: Icons.person,
              texto: 'Perfil',
              color: ColorsApp.colorTitle,
              ontap: const HomeScreen(),
            ),
            ListTileCustom(
              icon: Icons.sell_rounded,
              texto: 'Mi pedido',
              color: ColorsApp.colorTitle,
              ontap: const HomeScreen(),
            ),
            ListTileCustom(
              icon: Icons.history,
              texto: 'Historial',
              color: ColorsApp.colorTitle,
              ontap: const HomeScreen(),
            ),
            ListTileCustom(
              icon: Icons.add_business,
              texto: 'Locales',
              color: ColorsApp.colorTitle,
              ontap: const HomeScreen(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Divider(
                color: ColorsApp.colorPrimary,
                thickness: 2.0,
              ),
            ),
            ListTileCustom(
              texto: 'Ayuda en linea',
              icon: Icons.help_outlined,
              color: ColorsApp.colorTitle,
              ontap: const HomeScreen(),
            ),
            ListTileCustom(
              texto: 'Acerca de Nosotros',
              icon: Icons.info,
              color: ColorsApp.colorTitle,
              ontap: const AboutUsScreen(),
            ),
            ListTile(
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: ColorsApp.colorTitle,
                ),
              ),
              leading: Icon(
                Icons.logout_outlined,
                color: ColorsApp.colorTitle,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Cerrar Sesión?',
                      style: TextStyle(color: ColorsApp.colorTitle),
                    ),
                    content: Text(
                      '¿Estás seguro de Cerrar Sesión?',
                      style: TextStyle(color: ColorsApp.colorTitle),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'Si',
                          style: TextStyle(color: Colors.black26),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(); //Desabilita el dialogo
                          Navigator.pop(context); //Cerrar el Drawer
                        },
                      ),
                    ],
                    elevation: 24.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileCustom extends StatelessWidget {
  final String texto;
  final IconData icon;
  final Color color;
  final Widget? ontap;

  const ListTileCustom(
      {super.key,
      required this.texto,
      required this.icon,
      required this.color,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        texto,
        style: TextStyle(color: color),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ontap!));
      },
    );
  }
}
