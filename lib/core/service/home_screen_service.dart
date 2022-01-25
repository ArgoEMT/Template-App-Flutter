import '../api/home_screen_api.dart';

/// Service of the HomeScreen.
///
/// This is the link between the [HomeScreenViewModel] and the [HomeScreenAPI].
class HomeScreenService {
  final HomeScreenAPI _homeScreenAPI;

  HomeScreenService({
    required HomeScreenAPI homeScreenAPI,
  }) : _homeScreenAPI = homeScreenAPI;

  /// Dummy method.
  /// 
  /// This is just an example on how to use the VM -> Service -> API architecture.
  Future someWSCall() async {
    await _homeScreenAPI.someWSCall();
  }
}
