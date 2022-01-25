import 'package:flutter/material.dart';

import 'package:flutter_template/core/constants/route_paths.dart';
import 'package:flutter_template/core/view_models/screen/home_screen_view_model.dart';
import 'package:flutter_template/ui/screens/second_screen/second_screen.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeScreenViewModel model;

  final _controller = TextEditingController(text: 'Hey hey, Shinomiya-san!');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Entrer a text to pass to the second screen'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RoutePaths.secondScreen,
                arguments: SecondScreenArguments(
                  stringToDisplay: _controller.text,
                ),
              );
            },
            child: const Text('Second screen'),
          ),
        ],
      ),
    );
  }
}
