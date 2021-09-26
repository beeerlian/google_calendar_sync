import 'package:flutter/material.dart';
import 'package:google_calendar_synchronize/pages/home.dart';
import 'package:google_calendar_synchronize/pages/login.dart';

class GeneratedRoutes {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/login":
        return MaterialPageRoute(builder: (context) => const LoginPage());
      default:
        return onUnknownRoutes();
    }
  }

  static Route<dynamic> onUnknownRoutes() => MaterialPageRoute(builder: (context)=> const Scaffold(
                  body: Center(child: Text("Wrong route")),
                ));
}
