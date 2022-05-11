import 'package:flutter/material.dart';

import '../../shared/colors.dart';
import 'custom_outlined_button.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.textColor = primaryColor,
    this.horizontalPadding,
  }) : super(key: key);

  final double? horizontalPadding;

  /// Contenu du bouton.
  final Widget child;

  /// Fonctrion du bouton.
  final void Function()? onPressed;

  /// Couleur du text du bouton.
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      horizontalPadding: horizontalPadding,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: textColor,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}
