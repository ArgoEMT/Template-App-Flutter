import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/api/home_screen_api.dart';
import '../../core/service/home_screen_service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: HomeScreenAPI()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<HomeScreenAPI, HomeScreenService>(
    update: (_, homeScreenAPI, __) =>
        HomeScreenService(homeScreenAPI: homeScreenAPI),
  ),
];
