import 'package:flutter_template/core/service/home_screen_service.dart';

import '../components/base_view_model.dart';

/// View model of the homescreen.
///
/// It has an dummy init method that is used in the example.
class HomeScreenViewModel extends BaseViewModel {
  final HomeScreenService _homeScreenService;

  HomeScreenViewModel({
    required HomeScreenService homeScreenService,
  }) : _homeScreenService = homeScreenService;

  void init() async {
    // ignore: avoid_print
    print('Model is now init');
    await _homeScreenService.someWSCall();
  }
}
