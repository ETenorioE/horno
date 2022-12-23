import 'package:flutter/material.dart';
import 'package:horno/provider/provider_login.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/theme/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horno/services/notifications_service.dart';
import 'package:horno/services/voucher_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: BaseService.sURL, anonKey: BaseService.apiKey);

  runApp(const ProviderStateWidget());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..progressColor = ColorsApp.colorSecondary
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = ColorsApp.colorSecondary
    ..indicatorColor = ColorsApp.colorLight
    ..textColor = ColorsApp.colorLight
    ..maskColor = ColorsApp.colorSecondary.withOpacity(0.5);
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
        ChangeNotifierProvider(create: (_) => LocalsService()),
        ChangeNotifierProvider(create: (_) => VoucherService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => PaymentService()),

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
      builder: EasyLoading.init(),

    );
  }
}
