import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';
import 'package:horno/widgets/index.dart';

class MyRoutes {
  static const String rLOCALS = '/locals';
  static const String rLOCAL = '/local';
  static const String rHome = '/home';
  static const String rNOTIFY = '/notifications';
  static const String rVOUCHER = '/voucher';
  static const String rLOGIN = '/login';
  static const String rMyORDER = '/my-order';
  static const String rHISTORY = '/history';
  static const String rPAYMENT = '/payment';

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
      case ('/my-order'):
        return MaterialPageRoute(builder: (_) => const MyOrderPage());
      case ('/history'):
        return MaterialPageRoute(builder: (_) => const HistorialPage());
      case ('/payment'):
        return MaterialPageRoute(builder: (_) => const PaymentPage());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
