import 'package:flutter/material.dart';

class BetterTableauRow<T> {
  BetterTableauRow({
    required this.items,
    this.value,
    this.onClick,
    this.overflow = TextOverflow.clip,
    this.isSelectable = true,
  });

  /// Liste des éléments de la ligne.
  final List<dynamic> items;

  /// Valeur de la ligne.
  final T? value;

  /// Fonction appelé si l'utilisateur clique sur la ligne.
  final Function()? onClick;

  /// Overflow du text.
  final TextOverflow overflow;

  /// Si la ligne peut être sélectionnée.
  final bool isSelectable;
}
