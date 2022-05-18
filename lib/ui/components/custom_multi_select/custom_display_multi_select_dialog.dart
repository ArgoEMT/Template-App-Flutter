import 'package:flutter/material.dart';
import 'package:flutter_template/ui/components/custom_dialog.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/text_styles.dart';
import 'custom_multi_select.dart';

class CustomDisplayMultiSelectDialog<T> extends StatelessWidget {
  const CustomDisplayMultiSelectDialog({
    Key? key,
    required this.selectedItems,
    required this.items,
  }) : super(key: key);

  final BehaviorSubject<List<T?>> selectedItems;
  final List<CustomMultiSelectItem<T?>> items;

  String _getMultiSelectItemLabel(T? item) {
    final multiSelectItem =
        items.firstWhere((multiSelectItem) => multiSelectItem.value == item);
    return multiSelectItem.label;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: selectedItems.valueOrNull?.length == 1
          ? 'Destinataire sélectionné'
          : 'Destinataires sélectionnés',
      body: [
        SizedBox(
          height: 200,
          child: Theme(
            data: Theme.of(context).copyWith(
              scrollbarTheme: const ScrollbarThemeData(
                isAlwaysShown: true,
              ),
            ),
            child: StreamBuilder<List<T?>>(
              stream: selectedItems,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0) const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            _getMultiSelectItemLabel(item),
                            style: mediumTextStyle,
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
