import 'package:flutter/material.dart';

/// Arguments of the second screen.
class SecondScreenArguments {
  final String stringToDisplay;

  SecondScreenArguments({
    required this.stringToDisplay,
  });
}

/// Second screen of the app.
///
/// Take an [SecondScreenArguments].
class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);
  final SecondScreenArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(arguments.stringToDisplay),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
