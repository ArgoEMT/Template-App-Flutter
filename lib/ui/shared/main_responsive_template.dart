import 'package:flutter/material.dart';

import '../../core/constants/route_paths.dart';
import '../components/menu/main_menu.dart';

class MainResponsiveTemplate extends StatelessWidget {
  final Widget child;
  final Future<bool> Function()? onWillPop;

  const MainResponsiveTemplate({
    Key? key,
    required this.child,
    this.onWillPop,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ??
          () async {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              await Navigator.of(context).pushReplacementNamed(RoutePaths.home);
            }
            return Future.value(false);
          },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const MainMenu(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 304.0,
            child: Scaffold(
              drawerEnableOpenDragGesture: false,
              body: child,
            ),
          ),
        ],
      ),
    );
  }
}
