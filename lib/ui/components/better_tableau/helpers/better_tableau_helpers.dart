import 'package:flutter/material.dart';
import 'package:flutter_template/core/model/better_tableau/better_tableau_row.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/model/better_tableau/better_tableau_column.dart';
import '../../../../core/model/better_tableau/better_tableau_style.dart';
import '../../../shared/colors.dart';
import '../../../shared/text_styles.dart';
import '../../boutons/custom_text_button.dart';

class BetterTableauHepers {
  /// Créé une row
  static Widget _createRow<T>({
    required BetterTableauRow<T> row,
    required BetterTableauStyle style,
    required bool isCheckable,
    required bool isChecked,
    required BehaviorSubject<List<T?>>? selectedItems,
  }) {
    return Container(
      decoration: style.rowsBoxDecoration,
      height: style.rowHeight,
      child: Row(children: [
        if (isCheckable)
          GestureDetector(
            onTap: () {
              var tempList = selectedItems?.valueOrNull ?? [];
              if (!isChecked) {
                tempList.add(row.value);
                selectedItems?.add(tempList);
              } else {
                tempList.removeWhere((element) => element == row.value);
                selectedItems?.add(tempList);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                isChecked
                    ? Icons.check_box_sharp
                    : Icons.check_box_outline_blank_sharp,
                color: style.rowTextStyle.color,
              ),
            ),
          ),
        ...row.items.map(
          (item) {
            return Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item.toString(),
                  style: style.rowTextStyle,
                ),
              ),
            );
          },
        ).toList(),
      ]),
    );
  }

  /// Retourne une liste de int indiquant les pages à afficher
  static List<int> _getPagesToDisplay({
    required int currentPage,
    required int totalPages,
  }) {
    if (totalPages <= 3) {
      return List.generate(totalPages, (i) => i + 1);
    }
    if (currentPage <= 2) {
      return [1, 2, 3];
    }
    if (currentPage >= 3) {
      var tempList = [currentPage - 1, currentPage];
      if (currentPage < totalPages) {
        tempList.add(currentPage + 1);
      } else {
        tempList.insert(0, currentPage + -2);
      }

      return tempList;
    }
    return [];
  }

  /// Retourne un widget bouton de page
  static Widget _getFooterButton({
    required int pageNumber,
    required bool isCurrentPage,
    required void Function()? onPageChanged,
  }) {
    return CustomTextButton(
      onPressed: onPageChanged,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isCurrentPage ? secondaryColor : whiteColor,
        ),
        child: Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: Text(
            pageNumber.toString(),
            style: normalTextStyle.copyWith(
              color: isCurrentPage ? whiteColor : blackColor,
            ),
          ),
        ),
      ),
    );
  }

  /// Calcule le nombre de lignes à afficher par page
  static int _getLinesToDisplay({
    required int currentPage,
    required int totalRows,
  }) {
    var rest = totalRows - currentPage * 10;

    if (rest > 0) {
      return 10;
    } else {
      return 10 + rest;
    }
  }

  /// Retourne l'icone du boutton de sélection.
  static IconData _getToutSelectionnerIcon<T>({
    required List<T> selectedItems,
    required List<BetterTableauRow<T>> rows,
  }) {
    if (selectedItems.isEmpty) {
      return Icons.check_box_outline_blank_sharp;
    }
    if (selectedItems.length == rows.length) {
      return Icons.check_box_sharp;
    }
    return Icons.indeterminate_check_box_sharp;
  }

  /// Retourne le header du tableau
  static Widget createHeader<T>({
    required List<BetterTableauColumn> columns,
    required BetterTableauStyle style,
    required bool isCheckable,
    required BehaviorSubject<List<T?>>? selectedItems,
    required List<BetterTableauRow<T>> rows,
  }) {
    var listSelected = selectedItems?.valueOrNull ?? <T>[];

    return Container(
      decoration: style.headerBoxDecoration,
      height: style.headerHeight,
      child: Row(children: [
        if (isCheckable)
          GestureDetector(
            onTap: () {
              if (listSelected.isEmpty) {
                selectedItems?.add(rows.map((e) => e.value).toList());
              } else {
                selectedItems?.add([]);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                _getToutSelectionnerIcon(
                  rows: rows,
                  selectedItems: listSelected,
                ),
                color: whiteColor,
              ),
            ),
          ),
        ...columns.map((column) {
          return Expanded(
            flex: column.flex,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                column.title,
                style: style.headerTextStyle,
              ),
            ),
          );
        }).toList(),
      ]),
    );
  }

  /// Retourne le body du tableau
  static Widget createBody<T>({
    required List<BetterTableauRow<T>> rows,
    required BetterTableauStyle style,
    required bool isCheckable,
    required BehaviorSubject<List<T>>? selectedItems,
    required List<int> flexs,
    required int currentPage,
    required bool fixedHeight,
  }) {
    var firstIndex = (currentPage - 1) * 10;
    return StreamBuilder<List<T>>(
      stream: selectedItems,
      builder: (context, snapshot) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: fixedHeight
              ? 10
              : _getLinesToDisplay(
                  currentPage: currentPage,
                  totalRows: rows.length,
                ),
          itemBuilder: (context, index) {
            if (fixedHeight && firstIndex + index > rows.length - 1) {
              return Container(
                decoration: style.rowsBoxDecoration,
                height: style.rowHeight,
              );
            }
            return _createRow(
              selectedItems: selectedItems,
              row: rows[firstIndex + index],
              style: style,
              isCheckable: isCheckable,
              isChecked:
                  snapshot.data?.contains(rows[firstIndex + index].value) ??
                      false,
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
  /// - S'il a des lignes, chaques ligne doit avoir le même nombre d'item qu'il y a de colonnes
  /// - Si le tableau est checkable, il doit avoir une liste de sélection
  /// - Si le tableau est checkable, il doit y avoir une valeur dans chaque ligne
  /// - Si le tableau est paginé, le nombre total de page doit être renseigné
  /// - Si le tableau est paginé, une fonction de changement de page doit être renseignée
  static void isTableauViable<T>({
    required List<BetterTableauColumn> columns,
    required List<BetterTableauRow> rows,
    required bool isCheckable,
    required BehaviorSubject<List<T>>? selectedItems,
    required final bool isPaginated,
    required final Future Function(int page)? paginationFunction,
    required final int? totalPages,
  }) {
    if (columns.isEmpty) {
      throw Exception('Les colonnes ne peuvent être vide');
    }

    if (rows.any((row) => row.items.length != columns.length)) {
      throw Exception(
        'Les lignes doivent avec le même nombre d\'item que les colonnes',
      );
    }

    if (isCheckable && selectedItems == null) {
      throw Exception(
          'La tableau ne peut pas être checkable sans selectedItems');
    }

    if (isCheckable && rows.any((row) => row.value == null)) {
      throw Exception(
        'Pour un tableau checkable, toutes les lignes doivent avoir une valeur',
      );
    }

    if (isPaginated && paginationFunction == null) {
      throw Exception(
        'Pour un tableau paginé, une fonction de pagination doit être fournie',
      );
    }

    if (isPaginated && totalPages == null) {
      throw Exception(
        'Pour un tableau paginé, un nombre total de pages doit être fourni',
      );
    }
  }

  // Retourne le footer du tableau
  static Widget createFooter({
    required BetterTableauStyle style,
    required int currentPage,
    required int totalPages,
    required Function(int) onPageChanged,
  }) {
    var listPagesToDisplay = _getPagesToDisplay(
      currentPage: currentPage,
      totalPages: totalPages,
    );

    return Container(
      decoration: style.footerBoxDecoration,
      height: style.footerHeight,
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          ...listPagesToDisplay
              .map(
                (e) => _getFooterButton(
                  isCurrentPage: currentPage == e,
                  onPageChanged: () async => await onPageChanged(e),
                  pageNumber: e,
                ),
              )
              .toList(),
          if (totalPages > 3 && currentPage < totalPages - 2)
            Text(
              '...',
              style: normalTextStyle.copyWith(color: whiteColor),
            ),
          if (totalPages > 3 && currentPage < totalPages - 1)
            _getFooterButton(
              isCurrentPage: currentPage == totalPages,
              onPageChanged: () async => await onPageChanged(totalPages),
              pageNumber: totalPages,
            ),
        ],
      ),
    );
  }

  static int calcultateTotalPages({
    required List<BetterTableauRow> rows,
    required int itemsPerPage,
  }) {
    return (rows.length / itemsPerPage).ceilToDouble().toInt();
  }
}
