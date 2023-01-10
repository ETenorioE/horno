import 'package:flutter/material.dart';
import 'package:horno/pages/index.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/auth_service.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
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
              child: Center(
                child: TitleWidget(Preferences.emailShort),
              ),
            ),
            _ListTileCustom(
              icon: Icons.home_filled,
              text: 'Inicio',
              route: MyRoutes.rLOCALS,
            ),
            _ListTileCustom(
              icon: Icons.person,
              text: 'Perfil',
              route: MyRoutes.rLOCALS,
            ),
            _ListTileCustom(
              icon: Icons.sell_rounded,
              text: 'Mi pedido',
              route: MyRoutes.rMyORDER,
            ),
            _ListTileCustom(
              icon: Icons.history,
              text: 'Historial',
              route: MyRoutes.rHistoryOrder,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                color: ColorsApp.colorText,
                thickness: 0.5,
              ),
            ),
            _ListTileCustom(
              text: 'Acerca de Nosotros',
              icon: Icons.info,
              route: MyRoutes.rABOUT,
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
  final String text;
  final IconData icon;
  Color _color = ColorsApp.colorTitle;
  final String route;

  _ListTileCustom({
    super.key,
    required this.text,
    required this.icon,
    required this.route,
    Color? color,
  }) {
    _color = color ?? ColorsApp.colorTitle;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: _color),
      title: Text(
        text,
        style: TextStyle(color: _color),
      ),
      onTap: () => {Navigator.pushReplacementNamed(context, route)},
    );
  }
}
