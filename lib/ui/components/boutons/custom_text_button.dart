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
    this.hasSplash = true,
    this.isEnabled = true,
  }) : super(key: key);

  final double? horizontalPadding;

  /// Contenu du bouton.
  final Widget child;

  /// Fonctrion du bouton.
  final void Function()? onPressed;

  /// Couleur du text du bouton.
  final Color textColor;

  /// Renseigne si on veut un splash.
  final bool hasSplash;

  /// Si le bouton est activé
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      horizontalPadding: horizontalPadding,
      hasSplash: hasSplash,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        splashFactory: hasSplash ? null : NoSplash.splashFactory,
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
