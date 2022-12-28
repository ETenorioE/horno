import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:provider/provider.dart';

class VerifyAuthScreen extends StatelessWidget {
  const VerifyAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text(
              'Espere ...',
              style: TextStyle(fontSize: 28),
            );
          }

          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyRoutes.rLOGIN, (route) => false);
            });
          } else {
            Future.microtask(() {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyRoutes.rHome, (route) => false);
            });
          }

          return Container();
        },
      )),
    );
  }
}
