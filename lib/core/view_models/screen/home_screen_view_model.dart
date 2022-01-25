import 'package:rxdart/rxdart.dart';

import '../../service/home_screen_service.dart';
import '../components/base_view_model.dart';

/// View model of the homescreen.
///
/// It has an dummy init method that is used in the example.
class HomeScreenViewModel extends BaseViewModel {
  HomeScreenViewModel({
    required HomeScreenService homeScreenService,
  }) : _homeScreenService = homeScreenService;
  final HomeScreenService _homeScreenService;

  final _textController = BehaviorSubject<String>();

  Stream<String> get textStream => _textController.stream;

  set textValue(String newText) => _textController.add(newText);

  void init() async {
    textValue = 'Hey hey, Shinomiya-san!';
    await _homeScreenService.someWSCall();
  }
}
