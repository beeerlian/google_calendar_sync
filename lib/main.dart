import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_calendar_synchronize/routes/on_generated_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/login",
      onGenerateRoute: (settings) {
        return GeneratedRoutes.generate(settings);
      },
      onUnknownRoute: (settings) {
        return GeneratedRoutes.onUnknownRoutes();
      },
    );
  }
}
