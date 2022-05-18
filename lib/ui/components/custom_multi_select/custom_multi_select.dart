import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/colors.dart';
import '../../shared/text_styles.dart';
import 'custom_display_multi_select_dialog.dart';
import 'custom_multi_select_dialog.dart';

class CustomMultiSelect<T> extends StatelessWidget {
  const CustomMultiSelect({
    Key? key,
    required this.items,
    required this.selectedItems,
    this.isError = false,
    this.enable = true,
    this.hint = 'destinataire',
    this.canBeClicked = true,
    this.actionLabel = 'Ajouter',
    this.width,
  }) : super(key: key);

  /// Stream that contains the list of selected items.
  final BehaviorSubject<List<T>> selectedItems;

  /// List of items to display.
  final List<CustomMultiSelectItem<T>> items;

  /// True if the widget is in error state.
  final bool isError;

  /// True if the widget is enabled.
  final bool enable;

  /// Hint text to display.
  final String hint;

  /// True if the widget can be clicked.
  final bool canBeClicked;

  /// Width of the widget.
  final double? width;

  /// Label to display in the searchbar.
  final String actionLabel;

  String _getLabel(List<T?>? itemsSelected) {
    if (itemsSelected?.length == 1) {
      return enable ? '1 $hint sélectionné' : 'Consulter le $hint';
    }
    return enable
        ? '${itemsSelected?.length} ${hint}s sélectionnés'
        : 'Consulter les ${itemsSelected?.length} ${hint}s';
  }

  Widget get _body => Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: isError
                ? errorColor
                : enable
                    ? blackColor
                    : greyColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<List<T>>(
              stream: selectedItems,
              builder: (context, snapshot) =>
                  (!snapshot.hasData || snapshot.data?.isEmpty == true)
                      ? Text(
                          enable ? '$actionLabel un $hint' : 'Pas de $hint',
                          style: normalTextStyle.copyWith(color: greyColor),
                        )
                      : Text(
                          _getLabel(snapshot.data),
                          style: normalTextStyle.copyWith(
                            color: blackColor,
                          ),
                        ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: blackColor,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return canBeClicked
        ? GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => enable
                  ? CustomMultiSelectDialog<T>(
                      items: items,
                      selectedItems: selectedItems,
                      hint: hint,
                    )
                  : CustomDisplayMultiSelectDialog<T>(
                      items: items,
                      selectedItems: selectedItems,
                    ),
            ),
            child: _body,
          )
        : _body;
  }
}

/// Classe qui permet de faire le pont entre le type dynamic et la donnée à afficher à l'écran.
class CustomMultiSelectItem<T> {
  /// La valeur réel de l'objet.
  final T value;

  /// La valeur affichée à l'écran.
  final String label;

  CustomMultiSelectItem({
    required this.value,
    required this.label,
  });
}
