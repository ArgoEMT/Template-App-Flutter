class BetterTableauColumn {
  BetterTableauColumn({
    required this.title,
    this.flex = 1,
    this.subTitle,
  });

  final int flex;
  final dynamic subTitle;
  final String title;
}
