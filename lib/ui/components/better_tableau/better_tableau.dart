import 'package:flutter/material.dart';
import 'package:flutter_template/core/model/better_tableau/better_tableau_row.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/model/better_tableau/better_tableau_column.dart';
import '../../../core/model/better_tableau/better_tableau_style.dart';
import 'helpers/better_tableau_helpers.dart';

/// Tableau de données.
///
/// Peut être utilisé avec une pagination, ou avec des données statiques.
class BetterTableau<T> extends StatefulWidget {
  const BetterTableau({
    Key? key,
    required this.rows,
    required this.columns,
    this.currentPageIndex = 0,
    this.itemPerPage = 10,
    this.isPaginated = false,
    this.isCheckable = false,
    this.style = const BetterTableauStyle(),
    this.totalPages,
    this.selectedItems,
    this.isLoadingStream,
    this.paginationFunction,
    this.itemPerPageFunction,
  }) : super(key: key);

  /// Liste de columns du tableau.
  final List<BetterTableauColumn> columns;

  /// Index de la page actuelle (!!commence à 0!!).
  final int currentPageIndex;

  /// Indique si le tableau est checkable (si true, nécessite [selectedItems]).
  final bool isCheckable;

  /// Indique si le tableau est en cours de chargement (obligatoir si le tableau est paginé).
  final BehaviorSubject<bool>? isLoadingStream;

  /// Indique si le tableau est paginé.
  final bool isPaginated;

  ///Nombre d'item par page.
  final int itemPerPage;

  /// Fonction de changement de nombre d'item par page (obligatoire si le tableau est paginé).
  final Future Function(int nombreItem)? itemPerPageFunction;

  /// Fonction de pagination (obligatoire si le tableau est paginé).
  final Future Function(int page)? paginationFunction;

  /// List des lignes du tableau.
  final List<BetterTableauRow<T>> rows;

  /// Stream des items selectionnés (obligatoire si [isCheckable] == true).
  final BehaviorSubject<List<T>>? selectedItems;

  /// Style du tableau.
  final BetterTableauStyle style;

  /// Nombre total de pages (obligatoire si le tableau est paginé).
  final int? totalPages;

  @override
  State<BetterTableau<T>> createState() => _BetterTableauState<T>();
}

class _BetterTableauState<T> extends State<BetterTableau<T>> {
  /// Stream de la page actuelle.
  final _currentPageIndexStream = BehaviorSubject<int>();

  /// Stream qui indique le nombre d'objet par page.
  final _itemsPerPageStream = BehaviorSubject<int>();

  @override
  void dispose() {
    super.dispose();
    _currentPageIndexStream.close();
    _itemsPerPageStream.close();
  }

  @override
  void initState() {
    super.initState();
    BetterTableauHepers.isTableauViable(
      columns: widget.columns,
      rows: widget.rows,
      isCheckable: widget.isCheckable,
      selectedItems: widget.selectedItems,
      isPaginated: widget.isPaginated,
      paginationFunction: widget.paginationFunction,
      totalPages: widget.totalPages,
      isLoadingStream: widget.isLoadingStream,
      itemPerPageFunction: widget.itemPerPageFunction,
    );

    _currentPageIndexStream.add(widget.currentPageIndex);
    _itemsPerPageStream.add(widget.itemPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _currentPageIndexStream,
      builder: (context, pageSnapshot) {
        return StreamBuilder<List<T>>(
          stream: widget.selectedItems,
          builder: (context, selectionSnapshot) {
            return StreamBuilder<int>(
              stream: _itemsPerPageStream,
              builder: (context, itemsPerPageSnapshot) {
                return Column(
                  children: [
                    BetterTableauHepers.createHeader(
                      columns: widget.columns,
                      style: widget.style,
                      isCheckable: widget.isCheckable,
                      selectedItems: widget.selectedItems,
                      currentPageIndex: pageSnapshot.data ?? 0,
                      itemsPerPage: itemsPerPageSnapshot.data ?? 10,
                      rows: widget.rows,
                      isPaginated: widget.isPaginated,
                    ),
                    BetterTableauHepers.createBody(
                      rows: widget.rows,
                      style: widget.style,
                      isCheckable: widget.isCheckable,
                      selectedItems: widget.selectedItems,
                      isPaginated: widget.isPaginated,
                      currentPageIndex: pageSnapshot.data ?? 0,
                      itemsPerPage: itemsPerPageSnapshot.data ?? 10,
                      isLoadingStream: widget.isLoadingStream,
                      flexs:
                          widget.columns.map((column) => column.flex).toList(),
                    ),
                    BetterTableauHepers.createFooter(
                        style: widget.style,
                        currentPageIndex: pageSnapshot.data ?? 0,
                        selectedItems: selectionSnapshot.data ?? [],
                        itemPerPage: itemsPerPageSnapshot.data ?? 10,
                        totalPages: widget.totalPages ??
                            BetterTableauHepers.calcultateTotalPages(
                              itemsPerPage: itemsPerPageSnapshot.data ?? 10,
                              rows: widget.rows,
                            ),
                        onPageChanged: (page) async {
                          if (widget.paginationFunction != null) {
                            await widget.paginationFunction!(page);
                          }
                          _currentPageIndexStream.add(page);
                        },
                        onItemPerPageChanged: (int nombrePage) {
                          if (widget.itemPerPageFunction != null) {
                            widget.itemPerPageFunction!(nombrePage);
                          }
                          _currentPageIndexStream.add(0);
                          _itemsPerPageStream.add(nombrePage);
                        }),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
