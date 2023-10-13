import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/routing/router.dart';
import 'features/map/presentation/pages/map_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C277D)),
        useMaterial3: true,
      ),
      routerDelegate: beamerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: beamerDelegate),
      routeInformationParser: BeamerParser(),
    );
  }
}
