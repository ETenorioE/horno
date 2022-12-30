import 'package:flutter/material.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/widgets/drawer_partner.dart';
import 'package:horno/widgets/index.dart';

class HomePartner extends StatelessWidget {
  const HomePartner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenido',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerPartner(),
      body: Center(
          child: IconButton(
              onPressed: () {
                NotificationsService.showSnackbar('message');
              },
              icon: Icon(Icons.home))),
    );
  }
}
