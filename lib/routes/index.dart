import 'package:flutter/material.dart';
import 'package:horno/pages/index.dart';

class MyRoutes {
  static const String rLOCALS = '/locals';
  static const String rLOCAL = '/local';
  static const String rHomePartner = '/home-partner';
  static const String rNOTIFY = '/notifications';
  static const String rLOGIN = '/login';
  static const String rMyORDER = '/my-order';
  static const String rABOUT = '/about';
  static const String rPAYMENT = '/payment';
  static const String rOrderDetail = '/order-detail';
  static const String rHistoryOrder = '/records';
  static const String rONBOARD = '/onboard';
  static const String rVERIFY = '/verify';
  static const String rTypeRol = '/type-rol';
  static const String rLoginPartner = '/login-partner';
  static const String rRegisterBusiness = '/register-business';
  static const String rMyOrders = '/my-orders';
  static const String rStateProcess = '/state-process';
  static const String rRegisterServices = '/register-services';
  static const String rMyServices = '/my-services';
  static const String rRegisterClient = '/register-client';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/locals'):
        return MaterialPageRoute(builder: (_) => const LocalsPage());
      case ('/local'):
        return MaterialPageRoute(builder: (_) => const LocalPage());
      case ('/notifications'):
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case ('/login'):
        return MaterialPageRoute(builder: (_) => const LoginClientPage());
      case ('/my-order'):
        return MaterialPageRoute(builder: (_) => const MyOrderPage());
      case ('/records'):
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      case ('/about'):
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case ('/payment'):
        return MaterialPageRoute(builder: (_) => const PaymentPage());
      case ('/order-detail'):
        return MaterialPageRoute(builder: (_) => const OrderDetailPage());
      case ('/onboard'):
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case ('/verify'):
        return MaterialPageRoute(builder: (_) => const VerifyAuthScreen());
      case ('/type-rol'):
        return MaterialPageRoute(builder: (_) => const TypeRolPage());
      case ('/login-partner'):
        return MaterialPageRoute(builder: (_) => const LoginPartnerPage());
      case ('/register-business'):
        return MaterialPageRoute(builder: (_) => const RegisterBusinessPage());
      case ('/home-partner'):
        return MaterialPageRoute(builder: (_) => const HomePartner());
      case ('/my-orders'):
        return MaterialPageRoute(builder: (_) => const MyOrdersPage());
      case ('/state-process'):
        return MaterialPageRoute(builder: (_) => const StateProcessPage());
      case ('/register-services'):
        return MaterialPageRoute(builder: (_) => const RegisterServicesPage());
      case ('/my-services'):
        return MaterialPageRoute(builder: (_) => const MyServicesPage());
      case ('/register-client'):
        return MaterialPageRoute(builder: (_) => const RegisterClientScreen());

      default:
        return MaterialPageRoute(builder: (_) => const VerifyAuthScreen());
    }
  }
}
