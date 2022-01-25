import 'package:flutter/material.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/view_models/screen/home_screen_view_model.dart';
import '../../second_screen/second_screen.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({
    Key? key,
    required this.model,
  }) : super(key: key);

  final HomeScreenViewModel model;

  final _controller = TextEditingController(text: 'Hey hey, Shinomiya-san!');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'This is a dynamic preview in a Stateless widget using streams:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StreamBuilder<String>(
                    stream: model.textStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Text(snapshot.data!);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Entrer a text to pass to the second screen'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) => model.textValue = value,
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
