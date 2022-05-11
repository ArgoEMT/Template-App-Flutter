import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class CustomRowButton extends StatelessWidget {
  const CustomRowButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.iconData,
    this.iconSize,
    this.backgroundColor,
    this.borderColor,
    this.size,
    this.foregroundColor,
  }) : super(key: key);

  final void Function()? onPressed;
  final String label;
  final IconData? iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? iconSize;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    var itemColor =
        onPressed == null ? greyColor : foregroundColor ?? whiteColor;
    var style = OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor:
          onPressed == null ? greyColor : backgroundColor ?? primaryColor,
      side: BorderSide(
        color: onPressed == null ? greyColor : borderColor ?? primaryColor,
      ),
      onSurface: itemColor,
      fixedSize: size,
    );

    return OutlinedButton(
      style: style,
      onPressed: onPressed,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Row(
                children: [
                  Icon(
                    iconData,
                    size: iconSize,
                    color: itemColor,
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            Center(
              child: Text(
                label,
                style: TextStyle(color: itemColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
