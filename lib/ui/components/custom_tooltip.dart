import 'package:flutter/material.dart';

import '../shared/colors.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    Key? key,
    required this.message,
    required this.child,
    this.verticalOffset,
    this.waitDuration,
    this.isTap = false,
  }) : super(key: key);

  final String message;
  final Widget child;
  final double? verticalOffset;
  final Duration? waitDuration;
  final bool isTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode:
          isTap ? TooltipTriggerMode.tap : TooltipTriggerMode.longPress,
      waitDuration: waitDuration,
      verticalOffset: verticalOffset,
      message: message,
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(12),
      textStyle: const TextStyle(fontSize: 14, color: whiteColor),
      child: child,
    );
  }
}
