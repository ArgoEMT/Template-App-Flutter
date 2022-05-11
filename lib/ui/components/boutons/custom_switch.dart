import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      inactiveThumbColor: greyColor,
      inactiveTrackColor: greyColor.withOpacity(0.3),
      activeColor: secondaryColor,
      activeTrackColor: secondaryColor.withOpacity(0.3),
      value: value,
      onChanged: (value) => onChanged(value),
    );
  }
}
