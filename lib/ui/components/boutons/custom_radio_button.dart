import 'package:flutter/material.dart';

import '../../shared/colors.dart';

/// Template de RadioButton.
///
/// Necessite un bool [value].
class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.value,
    this.isSmall = false,
    this.borderColor = darkGreyColor,
    this.centerColor = secondaryColor,
  }) : super(key: key);

  /// Valeur du bouton.
  final bool value;

  /// Choisi la taille du radio bouton
  final bool isSmall;

  /// Couleur de la bordure du bouton.
  final Color borderColor;

  /// Couleur du centre fu bouton.
  final Color centerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSmall ? 14 : 18,
      width: isSmall ? 14 : 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? centerColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
