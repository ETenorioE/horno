import 'package:flutter/material.dart';
import 'package:horno/page/index.dart';

class MyRoutes {
  static const String rLOCALS = '/locals';
  static const String rLOCAL = '/local';
  static const String rHome = '/home';
  static const String rNOTIFY = '/notifications';
  static const String rVOUCHER = '/voucher';
  static const String rLOGIN = '/login';
  static const String rMyORDER = '/my-order';
  static const String rHISTORY = '/history';
  static const String rABOUT = '/about';
  static const String rPAYMENT = '/payment';
  static const String rORDER_DETAIL = '/order-detail';

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
      case ('/about'):
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case ('/payment'):
        return MaterialPageRoute(builder: (_) => const PaymentPage());
      case ('/order-detail'):
        return MaterialPageRoute(builder: (_) => const OrderDetailPage());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
