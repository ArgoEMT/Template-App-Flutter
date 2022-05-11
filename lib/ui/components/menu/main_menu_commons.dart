import 'package:flutter/material.dart';
import 'package:flutter_template/core/view_models/components/menu/menu_view_model.dart';

import '../../shared/colors.dart';
import '../../shared/menu_item.dart';

class MainMenuCommons {
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 1;

  final ScrollController _scrollController = ScrollController();
  Widget buildDrawerList({
    required MenuViewModel model,
    required Color textColor,
    required BuildContext context,
  }) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: model.menu.length,
      itemBuilder: (ctx, index) {
        var item = model.menu[index];

        return buildItem(
          context: context,
          item: item,
          leftPadding: 0.0,
          textColor: textColor,
          index: index,
          isEnable: item.isEnable,
        );
      },
    );
  }

  Widget buildItem({
    required MenuItem item,
    required double leftPadding,
    required Color textColor,
    required BuildContext context,
    required int index,
    bool isEnable = true,
    bool isRouteActive = false,
  }) {
    if (item.subMenu == null) {
      return buildTile(
        context: context,
        item: item,
        leftPadding: leftPadding,
        textColor: textColor,
        isEnable: isEnable,
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            bottom: 6, left: leftPadding + 10, right: 10, top: 6),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: textColor,
              dividerColor: blackColor.withOpacity(0.1),
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(secondary: textColor),
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              leading: _getIcon(item: item, color: textColor),
              title: Text(
                item.libelle,
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
              children: item.subMenu!.map((subItem) {
                return buildItem(
                  context: context,
                  item: subItem,
                  leftPadding: leftPadding + 10,
                  textColor: textColor,
                  index: 0,
                  isEnable: subItem.isEnable,
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
  }

  Widget buildTile({
    required MenuItem item,
    required double leftPadding,
    required Color textColor,
    required BuildContext context,
    Color? backgroundColor,
    bool isEnable = true,
  }) {
    var itemColor = primaryColor;
    return Padding(
      padding:
          EdgeInsets.only(bottom: 6, left: leftPadding + 10, right: 10, top: 6),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: _getIcon(item: item, color: itemColor),
          title: Text(
            item.libelle,
            style: TextStyle(
              color: itemColor,
            ),
          ),
          onTap: isEnable
              ? () {
                  if (item.action != null) {
                    item.action!();
                    // Navigator.pop(context);
                  }
                }
              : null,
        ),
      ),
    );
  }

  Widget _getIcon({
    required MenuItem item,
    required Color color,
  }) {
    return Icon(
      item.icon,
      color: color,
    );
  }
}
