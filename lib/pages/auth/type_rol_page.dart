import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:lottie/lottie.dart';

class TypeRolPage extends StatelessWidget {
  const TypeRolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/login.json', height: 100, width: 100),
            const SpaceHeight(10),
            const TitleWidget('Iniciar sesión como'),
            const SpaceHeight(10),
            SizedBox(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TypeRolWidget(
                      color: ColorsApp.colorSecondary,
                      icon: Icons.person,
                      onTap: () {
                        Preferences.rolApp = 'client';
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.rLOGIN);
                      },
                      text: 'Cliente'),
                  _TypeRolWidget(
                      onTap: () {
                        Preferences.rolApp = 'partners';
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.rLOGIN_PARTNER);
                      },
                      text: 'Socio',
                      icon: Icons.group,
                      color: ColorsApp.colorSecondary.withOpacity(.6))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TypeRolWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  final Color color;
  Color? _colorText;

  _TypeRolWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.icon,
    required this.color,
    Color? colorText,
  }) : super(key: key) {
    _colorText = colorText ?? ColorsApp.colorLight;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: _colorText,
            ),
            TextWidget(
              text,
              color: _colorText,
            ),
          ],
        ),
      ),
    );
  }
}
