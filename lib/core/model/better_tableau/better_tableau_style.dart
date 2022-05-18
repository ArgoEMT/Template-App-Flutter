import 'package:flutter/material.dart';

import '../../../../ui/shared/colors.dart';

class BetterTableauStyle {
  const BetterTableauStyle({
    this.evenRowsColor = whiteColor,
    this.oddRowsColor = whiteColor,
    this.hoveredColor = greyColor,
    this.headerHeight = 48,
    this.rowHeight = 48,
    this.footerHeight = 48,
    this.headerTextStyle = const TextStyle(
      color: whiteColor,
      fontSize: 16,
    ),
    this.rowTextStyle = const TextStyle(
      fontSize: 16,
      color: blackColor,
    ),
    this.footerTextStyle = const TextStyle(
      fontSize: 16,
      color: whiteColor,
    ),
    this.footerBoxDecoration = const BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
    ),
    this.headerBoxDecoration = const BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    this.rowsBoxDecoration = const BoxDecoration(
      border: Border.symmetric(
        horizontal: BorderSide(color: primaryColor),
      ),
    ),
    this.fixedHeight = false,
    this.emptyLabel = 'Pas de résultats',
  });

  /// Couleur des lignes paires.
  final Color evenRowsColor;

  /// Indique si le tableau a une hauteur fixe (si false, le tableau fera la taille d'un ligne * le nombre de ligne affiché).
  final bool fixedHeight;

  /// Box decoration du footer.
  final BoxDecoration footerBoxDecoration;

  /// Hateur du footer.
  final double footerHeight;

  /// TextStyle du footer.
  final TextStyle footerTextStyle;

  /// Box decoration du header.
  final BoxDecoration headerBoxDecoration;

  /// Hauteur du header.
  final double headerHeight;

  /// TextStyle des columns.
  final TextStyle headerTextStyle;

  /// Couleur lors qu'on hover une ligne.
  final Color hoveredColor;

  /// Couleur des lignes impaires.
  final Color oddRowsColor;

  /// Hauteur des lignes.
  final double rowHeight;

  /// Textstyle des lignes.
  final TextStyle rowTextStyle;

  /// Décoration des lignes.
  final BoxDecoration rowsBoxDecoration;

  /// Label affiché quand le tableau est vide.
  final String emptyLabel;
}
