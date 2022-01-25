import 'package:flutter/material.dart';
import 'package:flutter_template/core/view_models/screen/home_screen_view_model.dart';
import 'package:flutter_template/ui/components/base_widget.dart';
import 'package:flutter_template/ui/screens/home_screen/components/home_screen_body.dart';
import 'package:provider/provider.dart';

/// App's homescreen.
///
/// You'll find an examples of :
/// - Arguments passing using the navigator.
/// - Viewmodel usage.
/// - Provider usage.
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
