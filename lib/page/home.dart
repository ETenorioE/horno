import 'package:flutter/material.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Marte',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Center(
          child: IconButton(
              onPressed: () {
                NotificationsService.showSnackbar('message');
              },
              icon: Icon(Icons.home))),
    );
  }
}
