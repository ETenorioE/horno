import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with RenderPage {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<MyNotificationService>(context);
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: ColorsApp.colorLight,
        backgroundColor: ColorsApp.colorSecondary,
        strokeWidth: 4.0,
        onRefresh: () async {
          service.getMyNotifications(Preferences.userId);
        },
        child: ListView.builder(
          itemCount: service.notifications.length,
          itemBuilder: (context, index) {
            final item = service.notifications[index];
            return ItemNotify(
              activity: item.activityText,
              client: Preferences.emailShort,
              order: item.orderIdText,
              state: item.evaluateState,
              time: item.timeText,
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        context: context,
        currentIndex: -1,
      ),
    );
  }
}
