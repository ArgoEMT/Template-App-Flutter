import 'package:flutter/material.dart';

import '../../core/constants/route_paths.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/second_screen/second_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return _routeBuilder(
          target: const HomeScreen(),
          settings: settings,
        );

      case RoutePaths.secondScreen:
        return _routeBuilder(
          target: SecondScreen(
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

  static MaterialPageRoute _routeBuilder({
    required Widget target,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    return CustomPageRoute(
      builder: (context) {
        return target;
      },
      settings: settings,
      maintainState: maintainState,
    );
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  CustomPageRoute({
    required Widget Function(BuildContext) builder,
    RouteSettings? settings,
    bool maintainState = true,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
        );
}
