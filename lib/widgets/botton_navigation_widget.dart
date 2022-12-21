import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  final int? currentIndex;
  final BuildContext context;

  const BottomNavigationWidget({
    Key? key,
    this.onTap,
    this.currentIndex = 0,
    required this.context,
  }) : super(key: key);

  void handleTap(int value) {
    print(currentIndex);
    print(value);
    switch (value) {
      case 0:
        if (currentIndex! != 0) {
          Navigator.pushReplacementNamed(context, MyRoutes.rLOCALS);
        }
        break;
      case 1:
        if (currentIndex! != 1) {
          Navigator.pushReplacementNamed(context, MyRoutes.rMyORDER);
        }
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: ColorsApp.colorText, width: 1))),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'MiPedido'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Historial'),
        ],
        currentIndex: currentIndex == -1 ? 0 : currentIndex!,
        unselectedItemColor: ColorsApp.colorTitle,
        selectedItemColor: currentIndex == -1
            ? ColorsApp.colorTitle
            : ColorsApp.colorSecondary,
        onTap: ((value) => handleTap(value)),
      ),
    );
  }
}
