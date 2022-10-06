import 'package:employee/ui/pages/about.dart';
import 'package:employee/ui/pages/login.dart';
import 'package:employee/ui/pages/profile.dart';
import 'package:employee/ui/pages/setup.dart';
import 'package:employee/ui/pages/startUp.dart';
import 'package:flutter/material.dart';

class Routes {
  static const setUp = '/setUp';
  static const startUp = '/startUp';
  static const login = '/login';
  static const profile = '/profile';
  static const about = '/about';
  static Route? generate(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case setUp:
        return MaterialPageRoute(builder: (_) => SetUpPage());
      case startUp:
        return MaterialPageRoute(builder: (_) => const StartUpPage());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutPage());
    }
  }
}
