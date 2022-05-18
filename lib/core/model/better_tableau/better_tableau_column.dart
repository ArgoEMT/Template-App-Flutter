

class BetterTableauColumn {
  BetterTableauColumn({
    required this.title,
    this.flex = 1,
    this.subTitle,
    this.tooltip,
  });

  /// Flex de la colonne.
  final int flex;

  /// Widget ou sous titre de la colonne.
  final dynamic subTitle;

  /// Titre de la colonne.
  final String title;

  /// String du tooltip de la colonne.
  final String? tooltip;
}
