import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/model/better_tableau/better_tableau_column.dart';
import '../../../core/model/better_tableau/better_tableau_row.dart';
import '../../../core/model/better_tableau/better_tableau_style.dart';
import 'helpers/better_tableau_helpers.dart';

class BetterTableau<T> extends StatelessWidget {
  BetterTableau({
    Key? key,
    required this.columns,
    required this.rows,
    this.style = const BetterTableauStyle(),
    this.isCheckable = false,
    this.selectedItems,
    this.isPaginated = false,
    this.paginationFunction,
    this.totalPages,
    this.fixedHeight = true,
  }) : super(key: key);

  final List<BetterTableauColumn> columns;
  final List<BetterTableauRow<T>> rows;
  final BetterTableauStyle style;
  final bool isCheckable;
  final BehaviorSubject<List<T>>? selectedItems;
  final bool isPaginated;
  final Future Function(int page)? paginationFunction;
  final int? totalPages;
  final bool fixedHeight;

  final _currentPageStream = BehaviorSubject<int>.seeded(1);

  @override
  Widget build(BuildContext context) {
    BetterTableauHepers.isTableauViable(
      columns: columns,
      rows: rows,
      isCheckable: isCheckable,
      selectedItems: selectedItems,
      isPaginated: isPaginated,
      paginationFunction: paginationFunction,
      totalPages: totalPages,
    );
    _currentPageStream.add(1);

    return StreamBuilder<int>(
      stream: _currentPageStream,
      builder: (context, pageSnapshot) {
        return StreamBuilder<List<T>>(
            stream: selectedItems,
            builder: (context, selectionSnapshot) {
              return Column(
                children: [
                  BetterTableauHepers.createHeader(
                    columns: columns,
                    style: style,
                    isCheckable: isCheckable,
                    selectedItems: selectedItems,
                    rows: rows,
                  ),
                  BetterTableauHepers.createBody(
                    rows: rows,
                    style: style,
                    fixedHeight: fixedHeight,
                    isCheckable: isCheckable,
                    selectedItems: selectedItems,
                    currentPage: pageSnapshot.data ?? 1,
                    flexs: columns.map((column) => column.flex).toList(),
                  ),
                  BetterTableauHepers.createFooter(
                    currentPage: pageSnapshot.data ?? 1,
                    totalPages: totalPages ??
                        BetterTableauHepers.calcultateTotalPages(
                          itemsPerPage: 10,
                          rows: rows,
                        ),
                    style: style,
                    onPageChanged: paginationFunction ??
                        (page) {
                          _currentPageStream.add(page);
                        },
                  ),
                ],
              );
            });
      },
    );
  }
}
