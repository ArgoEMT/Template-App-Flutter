import 'package:flutter/material.dart';
import 'package:flutter_template/ui/components/custom_dialog.dart';
import 'package:flutter_template/ui/shared/colors.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/helpers/helpers_methods.dart';
import '../../shared/text_styles.dart';
import '../boutons/custom_text_button.dart';
import 'custom_multi_select.dart';

class CustomMultiSelectDialog<T> extends StatefulWidget {
  const CustomMultiSelectDialog({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.hint,
    this.canBeClicked = true,
    this.elevation = 24,
  }) : super(key: key);

  final String hint;
  final BehaviorSubject<List<T?>> selectedItems;
  final List<CustomMultiSelectItem<T?>> items;
  final bool canBeClicked;
  final double elevation;

  @override
  State<CustomMultiSelectDialog<T?>> createState() =>
      _CustomMultiSelectDialogState<T?>();
}

class _CustomMultiSelectDialogState<T>
    extends State<CustomMultiSelectDialog<T?>> {
  final _itemsToDisplayController =
      BehaviorSubject<List<CustomMultiSelectItem>>();

  @override
  void initState() {
    super.initState();
    _itemsToDisplayController.add(widget.items);
  }

  /// Retourne si le stream contient [item].
  bool _doStreamContainsItem(CustomMultiSelectItem? item) {
    if (widget.selectedItems.valueOrNull == null ||
        widget.selectedItems.value.isEmpty) {
      return false;
    }
    return widget.selectedItems.value.contains(item?.value);
  }

  /// Retourne si tous les adhérents ont été sélectionnés.
  bool get isEmpty {
    return widget.selectedItems.valueOrNull == null ||
        widget.selectedItems.value.isEmpty;
  }

  bool get isAllSelected {
    return widget.selectedItems.valueOrNull != null &&
        widget.selectedItems.value.length == widget.items.length;
  }

  /// Retourne l'icone du boutton de sélection.
  IconData get _bouttonIcon {
    if (isEmpty) {
      return Icons.check_box_outline_blank_sharp;
    }
    if (isAllSelected) {
      return Icons.check_box_sharp;
    }
    return Icons.indeterminate_check_box_sharp;
  }

  /// Ajoute ou supprime un adhérent du stream.
  void _addOrRemoveItemToStream(CustomMultiSelectItem? item, bool isAddition) {
    //? Si l'adhérent n'est pas dans le stream, on l'ajoute.
    if (isAddition) {
      if (widget.selectedItems.valueOrNull == null ||
          widget.selectedItems.value.isEmpty) {
        widget.selectedItems.add([item?.value]);
      } else {
        var tempList = widget.selectedItems.valueOrNull;
        tempList?.add(item?.value);
        widget.selectedItems.add(tempList!);
      }
    }
    //? Sinon on le supprime
    else {
      var tempList = widget.selectedItems.value;
      tempList.remove(item?.value);
      widget.selectedItems.add(tempList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      elevation: widget.elevation,
      showOkButton: widget.canBeClicked,
      title: '${widget.hint.capitalize}s',
      body: [
        SizedBox(
          height: 300,
          child: StreamBuilder(
            stream: widget.selectedItems,
            builder: (context, adherentSelectedSnapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Chercher un ${widget.hint}',
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _itemsToDisplayController.add(widget.items);
                        }
                        var listToDisplay = widget.items
                            .where((element) => element.label
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        _itemsToDisplayController.add(listToDisplay);
                      }),
                  const SizedBox(height: 12),
                  CustomTextButton(
                    onPressed: () {
                      if (isEmpty) {
                        //? On ajoute [...widget.listAdherents] et non pas widget.listAdherents pour éviter les problèmes de pointeur.

                        var tempList = (_itemsToDisplayController.valueOrNull ??
                            []) as List<CustomMultiSelectItem<T>>;
                        widget.selectedItems.add(
                          tempList.map((e) => e.value).toList(),
                        );
                      } else {
                        widget.selectedItems.add([]);
                      }
                    },
                    horizontalPadding: 4,
                    child: Row(
                      children: [
                        Icon(
                          _bouttonIcon,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          isEmpty ? 'Tout sélectionner' : 'Tout désélectionner',
                          style: normalTextStyle.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Theme(
                    data: Theme.of(context).copyWith(
                      scrollbarTheme: const ScrollbarThemeData(
                        isAlwaysShown: true,
                      ),
                    ),
                    child: Expanded(
                      child: StreamBuilder<List<CustomMultiSelectItem>>(
                        stream: _itemsToDisplayController,
                        builder: (context, adherentToDisplaysnapshot) {
                          if (!adherentToDisplaysnapshot.hasData) {
                            return Container();
                          }
                          return ListView.builder(
                            itemCount: adherentToDisplaysnapshot.data?.length,
                            itemBuilder: (context, index) {
                              var item = adherentToDisplaysnapshot.data?[index];
                              return GestureDetector(
                                onTap: () {
                                  var value = !_doStreamContainsItem(item);
                                  _addOrRemoveItemToStream(item, value);
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: _doStreamContainsItem(item),
                                        onChanged: (value) {
                                          _addOrRemoveItemToStream(
                                            item,
                                            value!,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: 286,
                                        child: Text(
                                          item!.label,
                                          style: normalTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
