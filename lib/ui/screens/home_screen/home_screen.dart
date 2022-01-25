import 'package:flutter/material.dart';
import '../../../core/view_models/screen/home_screen_view_model.dart';
import '../../components/base_widget.dart';
import 'components/home_screen_body.dart';
import 'package:provider/provider.dart';

/// App's homescreen.
///
/// You'll find an examples of :
/// - Arguments passing using the navigator.
/// - Viewmodel usage.
/// - Provider usage.
/// - Stream usage.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenViewModel>(
      model: HomeScreenViewModel(
        homeScreenService: Provider.of(context),
      ),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home screen'),
          ),
          body: HomeScreenBody(model: model),
        );
      },
    );
  }
}
