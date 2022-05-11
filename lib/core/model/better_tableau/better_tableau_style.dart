import 'package:flutter/material.dart';

import '../../../ui/shared/colors.dart';

class BetterTableauStyle {
  const BetterTableauStyle({
    this.evenRowsColor = whiteColor,
    this.oddRowsColor = const Color(0x0D711E5A),
    this.dividerColor = primaryColor,
    this.hoveredColor = const Color(0x3376B72E),
    this.headerHeight = 48,
    this.rowHeight = 48,
    this.dividerHeight = 0,
    this.footerHeight = 48,
    this.lignSeparationHeight = 0,
    this.footerTextStyle = const TextStyle(
      color: whiteColor,
      fontSize: 16,
    ),
    this.headerTextStyle = const TextStyle(
      color: whiteColor,
      fontSize: 16,
    ),
    this.rowTextStyle = const TextStyle(
      fontSize: 14,
      color: blackColor,
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
    this.rowsBoxDecoration = const BoxDecoration(),
    this.textTableauVide = 'Pas de document',
    this.footerLigneLabel = 'ligne',
    this.showDividers = false,
  });

  final Color dividerColor;
  final double dividerHeight;
  final Color evenRowsColor;
  final BoxDecoration footerBoxDecoration;
  final double footerHeight;
  final String footerLigneLabel;
  final TextStyle footerTextStyle;
  final BoxDecoration headerBoxDecoration;
  final double headerHeight;
  final TextStyle headerTextStyle;
  final Color hoveredColor;
  final double lignSeparationHeight;
  final Color oddRowsColor;
  final double rowHeight;
  final TextStyle rowTextStyle;
  final BoxDecoration rowsBoxDecoration;
  final bool showDividers;
  final String textTableauVide;
}
