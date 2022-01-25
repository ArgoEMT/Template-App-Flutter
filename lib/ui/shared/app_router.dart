import 'package:flutter/material.dart';

import '../../core/constants/route_paths.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/second_screen/second_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case RoutePaths.secondScreen:
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
              arguments: settings.arguments as SecondScreenArguments),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Pas de route définie pour ${settings.name}'),
            ),
          ),
        );
    }
  }
}
