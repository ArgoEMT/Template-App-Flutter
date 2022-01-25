import 'package:flutter/material.dart';
import '../../../core/constants/route_paths.dart';
import '../second_screen/second_screen.dart';

/// App's homescreen.
///
/// You'll find an exemple of arguments passing using the navigator.
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = TextEditingController(text: 'Hey hey, Shinomiya-san!');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Center(
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
            OutlinedButton(
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
      ),
    );
  }
}
