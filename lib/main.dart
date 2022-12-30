import 'package:flutter/material.dart';
import 'package:horno/preferences/index.dart';
import 'package:horno/provider/index.dart';
import 'package:horno/routes/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/theme/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: BaseService.sURL, anonKey: BaseService.apiKey);

  await Preferences.init();

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
        ChangeNotifierProvider(create: (_) => LocalsService()),
        ChangeNotifierProvider(create: (_) => VoucherService()),
        ChangeNotifierProvider(create: (_) => LocalsService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => PaymentService()),
        ChangeNotifierProvider(create: (_) => LauncherProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PartnerAuthProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

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
      initialRoute: MyRoutes.rVERIFY,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: EasyLoading.init(),
    );
  }

  Future initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId('0fb6fe8d-13fe-468f-94e2-fae7043373a3');

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((value) => print('Permiso aceptado: $value'));
  }
}
