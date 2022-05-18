import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kIsWeb ? 32 : 0,
          vertical: kIsWeb ? 16 : 10,
        ),
        child: child,
      ),
    );
  }
}
