import 'package:flutter/material.dart';
import 'package:flutter_template/ui/shared/main_responsive_template.dart';

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
    return MainResponsiveTemplate(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(arguments.stringToDisplay),
            ElevatedButton(
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
