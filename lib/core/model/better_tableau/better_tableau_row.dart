

class BetterTableauRow<T> {
  BetterTableauRow({
    required this.items,
    this.value,
  });

  final List<String> items;
  final T? value;
}
