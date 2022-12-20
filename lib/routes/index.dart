import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';

class MyRoutes {
  static const String rLOCALS = '/locals';
  static const String rLOCAL = '/local';
  static const String rHome = '/home';
  static const String rNOTIFY = '/notifications';
  static const String rVOUCHER = '/voucher';
  static const String rLOGIN = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/locals'):
        return MaterialPageRoute(builder: (_) => const LocalsPage());
      case ('/local'):
        return MaterialPageRoute(builder: (_) => const LocalPage());
      case ('/home'):
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case ('/notifications'):
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case ('/voucher'):
        return MaterialPageRoute(builder: (_) => const VoucherPage());
      case ('/login'):
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
