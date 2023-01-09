import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/widgets/drawer_partner.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class HomePartner extends StatelessWidget {
  const HomePartner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PartnerService>(context);
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                NotificationsService.showSnackbar('message');
              },
              icon: const Icon(Icons.home)),
          TitleWidget(service.businessName ?? Preferences.localName),
        ],
      )),
    );
  }
}
