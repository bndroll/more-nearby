import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/notifications/notifications.dart';
import 'package:vtb_map/core/routing/router.dart';
import 'package:vtb_map/core/theming/light_theme.dart';
import 'features/map/presentation/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
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
      theme: lightTheme,
      routerDelegate: beamerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: beamerDelegate),
      routeInformationParser: BeamerParser(),
    );
  }
}

