import 'package:flutter/material.dart';
import 'package:flutter_template/ui/shared/colors.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/helpers/helpers_methods.dart';
import '../../../../core/model/better_tableau/better_tableau_column.dart';
import '../../../../core/model/better_tableau/better_tableau_row.dart';
import '../../../../core/model/better_tableau/better_tableau_style.dart';
import '../../../shared/text_styles.dart';
import '../../boutons/custom_text_button.dart';
import '../../custom_drop_down_form_field.dart';

class BetterTableauHepers {
  /// Créé une ligne de tableau.
  static Widget _createRow<T>({
    required bool isEven,
    required bool isChecked,
    required bool isCheckable,
    required List<int> flexs,
    required BetterTableauRow<T?> row,
    required BetterTableauStyle style,
    required BehaviorSubject<List<T?>>? selectedItems,
  }) {
    var _normalColor = isEven ? style.evenRowsColor : style.oddRowsColor;
    var _isHovered = BehaviorSubject<bool>();

    var _rowItems = <Widget>[];

    for (var i = 0; i < row.items.length; i++) {
      _rowItems.add(
        Expanded(
          flex: flexs[i],
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10),
            child: row.items[i] is String
                ? Text(
                    row.items[i].toString(),
                    style: style.rowTextStyle,
                    textAlign: TextAlign.center,
                    overflow: row.overflow,
                  )
                : row.items[i],
          ),
        ),
      );
    }

    return StreamBuilder<bool>(
      stream: _isHovered,
      builder: (context, snapshot) {
        var data = snapshot.data ?? false;
        return MouseRegion(
          onEnter: (event) => _isHovered.add(true),
          onExit: (event) => _isHovered.add(false),
          cursor: row.onClick != null && data
              ? SystemMouseCursors.click
              : MouseCursor.defer,
          child: GestureDetector(
            onTap: row.onClick,
            child: Container(
              decoration: style.rowsBoxDecoration.copyWith(
                color: row.onClick != null && data
                    ? style.hoveredColor
                    : _normalColor,
              ),
              height: style.rowHeight,
              child: Row(
                children: [
                  if (isCheckable)
                    CustomTextButton(
                      isEnabled: row.isSelectable,
                      hasSplash: false,
                      onPressed: () {
                        var tempList = selectedItems?.valueOrNull ?? [];
                        if (!isChecked) {
                          tempList.add(row.value);
                          selectedItems?.add(tempList);
                        } else {
                          tempList
                              .removeWhere((element) => element == row.value);
                          selectedItems?.add(tempList);
                        }
                      },
                      child: Icon(
                        row.isSelectable
                            ? isChecked
                                ? Icons.check_box_sharp
                                : Icons.check_box_outline_blank_sharp
                            : Icons.check_box_outline_blank_sharp,
                        color: row.isSelectable
                            ? style.rowTextStyle.color
                            : greyColor,
                      ),
                    ),
                  ..._rowItems,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Retourne une liste de int indiquant les pages à afficher
  static List<int> _getPagesToDisplay({
    required int totalPages,
    required int currentPage,
  }) {
    // -99 permet de savoir plus tard s'il faut afficher la page ou une séparation
    if (totalPages <= 4) {
      return List.generate(totalPages, (i) => i + 1);
    }
    var nextPage = currentPage + 1;
    var previousPage = currentPage - 1;

    var tempList = <int>[];
    if (currentPage < 3) {
      return [1, 2, 3, -99, totalPages];
    }
    if (currentPage == totalPages) {
      return [1, -99, totalPages - 2, totalPages - 1, totalPages];
    }

    tempList.add(1);
    if (previousPage - 1 == 1) {
      tempList.add(previousPage);
    } else {
      tempList.add(-99);
      tempList.add(previousPage);
    }

    tempList.add(currentPage);

    if (nextPage + 1 >= totalPages) {
      tempList.add(nextPage);
      if (nextPage < totalPages) {
        tempList.add(totalPages);
      }
    } else {
      tempList.add(nextPage);
      tempList.add(-99);
      tempList.add(totalPages);
    }
    return tempList;
  }

  /// Retourne un widget bouton de page
  static Widget _getFooterButton({
    required int pageNumber,
    required bool isCurrentPage,
    required Function() onPageChanged,
    required BetterTableauStyle style,
  }) {
    var _isHovered = BehaviorSubject<bool>();

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: pageNumber != -99
          ? StreamBuilder<bool>(
              stream: _isHovered,
              builder: (context, snapshot) {
                var data = snapshot.data ?? false;
                return MouseRegion(
                  onEnter: (event) => _isHovered.add(true),
                  onExit: (event) => _isHovered.add(false),
                  cursor: !isCurrentPage
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  child: GestureDetector(
                    onTap: onPageChanged,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isCurrentPage
                            ? secondaryColor
                            : data
                                ? secondaryColor
                                : whiteColor,
                      ),
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: Text(
                          pageNumber.toString(),
                          style: normalTextStyle.copyWith(
                            color: isCurrentPage
                                ? whiteColor
                                : data
                                    ? whiteColor
                                    : blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Text('...', style: style.footerTextStyle),
    );
  }

  /// Calcule le nombre de lignes à afficher par page
  static int _getLinesToDisplay<T>({
    required List<T> rows,
    required int totalRows,
    required int itemPerPage,
    required int currentPage,
    required bool isPaginated,
  }) {
    if (isPaginated) {
      return rows.length;
    }

    var rest = totalRows - (currentPage + 1) * itemPerPage;

    if (rest > 0) {
      return itemPerPage;
    } else {
      return itemPerPage + rest;
    }
  }

  /// Retourne si tous les document sont sélectionnés. Diffère si le tableau est paginé.
  ///
  /// Si le tableau est paginé, on affiche true si toutes les lignes de rows sont présentes dans selectedItems.
  /// Si le tableau n'est pas paginé, on affiche true si toutes les lignes de rows de la page actuelle sont présentes dans selectedItems.
  static bool _checkAllSelected<T>({
    required int itemPerPage,
    required int currentPage,
    required bool isPaginated,
    required List<T> selectedItems,
    required List<BetterTableauRow<T>> rows,
  }) {
    if (selectedItems.isEmpty) {
      return false;
    }
    var subList = _getCheckableSubList(
      currentPage: currentPage,
      rows: rows,
      isPaginated: isPaginated,
      selectedItems: selectedItems,
      itemPerPage: itemPerPage,
    );

    for (var item in subList) {
      if (!selectedItems.contains(item)) {
        return false;
      }
    }
    return true;
  }

  /// Retourne l'icone du boutton de sélection.
  static IconData _getToutSelectionnerIcon<T>({
    required int currentPage,
    required int itemPerPage,
    required bool isPaginated,
    required List<T?> selectedItems,
    required List<BetterTableauRow<T?>> rows,
  }) {
    var isAllSelected = _checkAllSelected(
      currentPage: currentPage,
      rows: rows,
      isPaginated: isPaginated,
      selectedItems: selectedItems,
      itemPerPage: itemPerPage,
    );

    var subList = _getCheckableSubList(
      currentPage: currentPage,
      rows: rows,
      isPaginated: isPaginated,
      selectedItems: selectedItems,
      itemPerPage: itemPerPage,
    );

    var isAnySelected = selectedItems.containsAny(subList);

    if (selectedItems.isEmpty || (!isAllSelected && !isAnySelected)) {
      return Icons.check_box_outline_blank_sharp;
    }

    if (isAllSelected) {
      return Icons.check_box_sharp;
    }
    return Icons.indeterminate_check_box_sharp;
  }

  /// Fonction de sélection de toutes les lignes, elle diffère si le tableau est paginé.
  ///
  /// Si le tableau est paginé, on supprimer ou ajoute toutes les lignes de rows.
  /// Si le tableau n'est pas paginé, on supprimer ou ajoute toutes les lignes de rows de la page courante.
  static void _fonctionAllSelected<T>({
    required int currentPage,
    required int itemPerPage,
    required bool isPaginated,
    required List<BetterTableauRow<T?>>? rows,
    required BehaviorSubject<List<T?>>? selectedItems,
  }) {
    if (rows == null || rows.isEmpty) {
      return;
    }
    var isAllSelected = _checkAllSelected(
      rows: rows,
      selectedItems: selectedItems?.valueOrNull ?? <T>[],
      currentPage: currentPage,
      itemPerPage: itemPerPage,
      isPaginated: isPaginated,
    );
    var tempList = selectedItems?.valueOrNull ?? <T>[];
    if (isPaginated) {
      if (isAllSelected) {
        tempList.removeWhere((element) => rows.contains(element));
      } else {
        var canBeSelectedList =
            rows.where((element) => element.isSelectable).toList();
        tempList.addAll(canBeSelectedList.map((e) => e.value).toList());
      }
    } else {
      var currentIndex = (currentPage - 1) * itemPerPage;
      var endIndex = currentIndex + itemPerPage;
      if (endIndex > rows.length) {
        endIndex = rows.length;
      }
      var subListRows = _getCheckableSubList(
        currentPage: currentPage,
        rows: rows,
        isPaginated: isPaginated,
        selectedItems: selectedItems?.valueOrNull ?? <T>[],
        itemPerPage: itemPerPage,
      );
      if (isAllSelected || tempList.containsAny(subListRows)) {
        for (var item in subListRows) {
          tempList.removeWhere((element) => element == item);
        }
      } else {
        tempList.addAll(subListRows);
      }
    }
    selectedItems?.add(tempList);
  }

  /// Retourne une liste des éléments qui peuvent être sélectionnés.
  ///
  /// Retourne une sous liste ne prenant en compte que les objets de la page actuelle.
  /// Si le tableau est paginé, on affiche simplement tous les objets de rows.
  static List<T?> _getCheckableSubList<T>({
    required int itemPerPage,
    required int currentPage,
    required bool isPaginated,
    required List<T> selectedItems,
    required List<BetterTableauRow<T>> rows,
  }) {
    if (rows.isEmpty) {
      return [];
    }
    if (isPaginated) {
      return rows.map((element) => element.value).toList();
    }
    var currentIndex = (currentPage - 1) * itemPerPage;
    var endIndex = currentIndex + itemPerPage;
    if (endIndex > rows.length && rows.length != 1) {
      endIndex = rows.length - 1;
    } else if (rows.length == 1) {
      endIndex = 1;
    }

    var tempSubList = rows.sublist(currentIndex, endIndex);
    tempSubList.removeWhere((element) => !element.isSelectable);

    return tempSubList.map((element) => element.value).toList();
  }

  /// Retourne le header du tableau
  static Widget createHeader<T>({
    required int itemsPerPage,
    required bool isCheckable,
    required bool isPaginated,
    required int currentPageIndex,
    required BetterTableauStyle style,
    required List<BetterTableauRow<T>> rows,
    required List<BetterTableauColumn> columns,
    required BehaviorSubject<List<T>>? selectedItems,
  }) {
    var listSelected = selectedItems?.valueOrNull ?? <T>[];

    return Container(
      decoration: style.headerBoxDecoration,
      height: style.headerHeight,
      child: Row(
        children: [
          if (isCheckable)
            CustomTextButton(
              hasSplash: false,
              onPressed: () {
                _fonctionAllSelected(
                  selectedItems: selectedItems,
                  rows: rows,
                  isPaginated: isPaginated,
                  currentPage: currentPageIndex + 1,
                  itemPerPage: itemsPerPage,
                );
              },
              child: Icon(
                _getToutSelectionnerIcon(
                  rows: rows,
                  selectedItems: listSelected,
                  currentPage: currentPageIndex + 1,
                  itemPerPage: itemsPerPage,
                  isPaginated: isPaginated,
                ),
                color: whiteColor,
              ),
            ),
          ...columns.map(
            (column) {
              return Expanded(
                flex: column.flex,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: column.tooltip ?? '',
                        child: Text(
                          column.title,
                          style: style.headerTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (column.subTitle != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          height: style.headerHeight * 0.5,
                          // width: 150,
                          child: column.subTitle,
                        ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }

  /// Retourne le body du tableau
  static Widget createBody<T>({
    required List<int> flexs,
    required bool isCheckable,
    required bool isPaginated,
    required int itemsPerPage,
    required int currentPageIndex,
    required BetterTableauStyle style,
    required List<BetterTableauRow<T?>> rows,
    required BehaviorSubject<bool>? isLoadingStream,
    required BehaviorSubject<List<T?>>? selectedItems,
  }) {
    var firstIndex = 0;
    if (!isPaginated) {
      firstIndex = currentPageIndex * itemsPerPage;
    }
    return StreamBuilder<List<T?>>(
      stream: selectedItems,
      builder: (context, selectedSnapshot) {
        return StreamBuilder<bool>(
          stream: isLoadingStream,
          builder: (context, loadingSnapshot) {
            if ((!loadingSnapshot.hasData || loadingSnapshot.data == true) &&
                isPaginated) {
              return Container(
                height: style.rowHeight * itemsPerPage,
                decoration: style.rowsBoxDecoration,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (rows.isEmpty) {
              return Container(
                decoration: style.rowsBoxDecoration,
                height: style.rowHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(style.emptyLabel, style: style.rowTextStyle),
                  ],
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: style.fixedHeight
                  ? itemsPerPage
                  : _getLinesToDisplay(
                      isPaginated: isPaginated,
                      currentPage: currentPageIndex,
                      totalRows: rows.length,
                      itemPerPage: itemsPerPage,
                      rows: rows,
                    ),
              itemBuilder: (context, index) {
                var isEven = index % 2 == 0;

                // S'il n'y a plus de ligne à afficher.
                if (style.fixedHeight && firstIndex + index > rows.length - 1) {
                  return Container(
                    decoration: style.rowsBoxDecoration,
                    height: style.rowHeight,
                  );
                }
                return _createRow(
                  isEven: isEven,
                  selectedItems: selectedItems,
                  row: rows[firstIndex + index],
                  style: style,
                  isCheckable: isCheckable,
                  isChecked: selectedSnapshot.data
                          ?.contains(rows[firstIndex + index].value) ??
                      false,
                  flexs: flexs,
                );
              },
            );
          },
        );
      },
    );
  }

  /// Throw une exception si le tableau n'est pas viable.
  ///
  /// Pour être viable, le tableau doit:
  /// - Avoir une liste de colonnes
  /// - S'il a des lignes, chaques ligne doit avoir le même nombre d'item qu'il y a de colonnes.
  /// - Si le tableau est checkable, il doit avoir une liste de sélection.
  /// - Si le tableau est checkable, il doit y avoir une valeur dans chaque ligne.
  /// - Si le tableau est paginé, le nombre total de page doit être renseigné.
  /// - Si le tableau est paginé, une fonction de changement de page doit être renseignée.
  /// - Si le tableau est paginé, le stream de chargement doit être renseigné.
  /// - Si le tableau est paginé, la fonction permettant de changer le nombre d'item par page doit être fournie.
  static void isTableauViable<T>({
    required int? totalPages,
    required bool isCheckable,
    required bool isPaginated,
    required List<BetterTableauRow> rows,
    required List<BetterTableauColumn> columns,
    required BehaviorSubject<List<T>>? selectedItems,
    required BehaviorSubject<bool>? isLoadingStream,
    required Future Function(int page)? paginationFunction,
    required Future Function(int nombreItems)? itemPerPageFunction,
  }) {
    if (columns.isEmpty) {
      throw Exception('Les colonnes ne peuvent être vide.');
    }

    if (rows.any((row) => row.items.length != columns.length)) {
      throw Exception(
        'Les lignes doivent avec le même nombre d\'item que les colonnes.',
      );
    }

    if (isCheckable && selectedItems == null) {
      throw Exception(
          'La tableau ne peut pas être checkable sans selectedItems.');
    }

    if (isCheckable && rows.any((row) => row.value == null)) {
      throw Exception(
        'Pour un tableau checkable, toutes les lignes doivent avoir une valeur.',
      );
    }

    if (isPaginated && paginationFunction == null) {
      throw Exception(
        'Pour un tableau paginé, une fonction de pagination doit être fournie.',
      );
    }

    if (isPaginated && totalPages == null) {
      throw Exception(
        'Pour un tableau paginé, un nombre total de pages doit être fourni.',
      );
    }

    if (isPaginated && isLoadingStream == null) {
      throw Exception(
        'Pour un tableau paginé, un stream de chargement doit être fourni.',
      );
    }

    if (isPaginated && itemPerPageFunction == null) {
      throw Exception(
        'Pour un tableau paginé, une fonction gérant le changement d\'objet par page doit être fournie.',
      );
    }
  }

  /// Retourne le footer du tableau
  ///
  ///
  static Widget createFooter<T>({
    required int totalPages,
    required int itemPerPage,
    required int currentPageIndex,
    required List<T> selectedItems,
    required BetterTableauStyle style,
    required Function(int) onPageChanged,
    required Function(int) onItemPerPageChanged,
  }) {
    var listPagesToDisplay = _getPagesToDisplay(
      currentPage: currentPageIndex + 1,
      totalPages: totalPages,
    );

    return Container(
      decoration: style.footerBoxDecoration,
      height: style.footerHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selectedItems.isNotEmpty
                ? SizedBox(
                    width: 170,
                    child: Text(
                      '${selectedItems.length} ligne${selectedItems.length == 1 ? '' : 's'} sélectionnée${selectedItems.length == 1 ? '' : 's'}',
                      style: style.footerTextStyle,
                    ),
                  )
                : const SizedBox(width: 170),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Lignes par page: ',
                  style: style.footerTextStyle,
                ),
                SizedBox(
                  height: 25,
                  child: CustomDropdownFormField(
                    items: const ['10', '25', '50', '100'],
                    value: itemPerPage.toString(),
                    onChanged: (value) {
                      onItemPerPageChanged(int.parse(value));
                    },
                    width: 30,
                    hint: 'Nombre d\'éléments par page',
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 242,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...listPagesToDisplay
                      .map(
                        (e) => _getFooterButton(
                          isCurrentPage: (currentPageIndex + 1) == e,
                          onPageChanged: (currentPageIndex + 1) == e
                              ? () {}
                              : () async => await onPageChanged(e - 1),
                          pageNumber: e,
                          style: style,
                        ),
                      )
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Calcule le total de page du tableau.
  ///
  /// Utilisé si totalPages n'est pa renseigné.
  static int calcultateTotalPages({
    required int itemsPerPage,
    required List<BetterTableauRow> rows,
  }) {
    return (rows.length / itemsPerPage).ceilToDouble().toInt();
  }
}
