import 'package:flutter/material.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/widgets/index.dart';

class NotificationPage extends StatelessWidget with RenderPage {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarRender(
          title: "Notificaciones",
          leading: InkWell(
            onTap: (() {
              Navigator.pushReplacementNamed(context, MyRoutes.rLOCALS);
            }),
            child: Icon(
              Icons.arrow_back,
              color: ColorsApp.colorLight,
            ),
          )),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ItemNotify(
            client: "Jheremy Saavedra",
            order: "433",
            state: StateNotify.notify,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(
        context: context,
        currentIndex: -1,
      ),
    );
  }
}
