import 'package:flutter/material.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/services/voucher_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderStateWidget());
}

class ProviderStateWidget extends StatelessWidget {
  const ProviderStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => LocalsService())),
        ChangeNotifierProvider(create: (_) => VoucherService()),
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horno',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MyRoutes.generateRoute,
      initialRoute: MyRoutes.rONBOARD,
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
