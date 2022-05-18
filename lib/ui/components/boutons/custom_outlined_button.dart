import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.horizontalPadding,
    this.style,
    this.backGroundColor,
    this.hasSplash = true,
  }) : super(key: key);

  final double? horizontalPadding;
  final void Function()? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Color? backGroundColor;

  /// Renseigne si on veut un splash.
  final bool hasSplash;

  @override
  Widget build(BuildContext context) {
    ButtonStyle _style;
    if (style != null) {
      _style = style!.copyWith(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          overlayColor: !hasSplash
              ? MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                  return Colors.transparent; // Defer to the widget's default.
                })
              : null);
    } else {
      _style = OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0), backgroundColor: backGroundColor);
    }
    return OutlinedButton(
      style: _style,
      onPressed: onPressed,
      child: Container(
        height: 38,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: child),
          ],
        ),
      ),
    );
  }
}
