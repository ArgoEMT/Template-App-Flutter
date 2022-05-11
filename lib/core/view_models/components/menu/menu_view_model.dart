import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/route_paths.dart';
import 'package:flutter_template/core/view_models/components/base_view_model.dart';

import '../../../../ui/shared/menu_item.dart';

class MenuViewModel extends BaseViewModel {
  List<MenuItem> get menu => [
        MenuItem(
          icon: Icons.home,
          libelle: 'Home',
          routePaths: [RoutePaths.home],
        ),
      ];
}
