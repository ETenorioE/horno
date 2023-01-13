import 'package:flutter/material.dart';
import 'package:horno/pages/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/services/auth_service.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class DrawerPartner extends StatelessWidget {
  const DrawerPartner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2019/04/26/07/14/store-4156934_960_720.png'),
                  ),
                  const SpaceWidth(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleWidget(Preferences.emailShort),
                      TitleWidget(Preferences.localName),
                    ],
                  ),
                ],
              ),
            ),
            _ListTileCustom(
              icon: Icons.home_filled,
              texto: 'Inicio',
              color: ColorsApp.colorTitle,
              ontap: const HomePartner(),
            ),
            _ListTileCustom(
              icon: Icons.sell_rounded,
              texto: 'Mis pedidos',
              color: ColorsApp.colorTitle,
              ontap: const MyOrdersPage(),
            ),
            _ListTileCustom(
              icon: Icons.book,
              texto: 'Mis Servicios',
              color: ColorsApp.colorTitle,
              ontap: const MyServicesPage(),
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
                        onPressed: () async {
                          await authService.logout();

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TypeRolPage()),
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

class _ListTileCustom extends StatelessWidget {
  final String texto;
  final IconData icon;
  final Color color;
  final Widget? ontap;

  const _ListTileCustom(
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
