import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/route_paths.dart';
import 'ui/shared/app_router.dart';
import 'ui/shared/app_theme.dart';
import 'ui/shared/provider_setup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RoutePaths.home,
      ),
    );
  }
}
