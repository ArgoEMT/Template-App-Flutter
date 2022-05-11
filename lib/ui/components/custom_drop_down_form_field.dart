import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/text_styles.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    Key? key,
    required this.items,
    required this.value,
    required this.width,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final String value;
  final double width;
  final String hint;
  final void Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 40,
      child: DropdownButtonFormField(
        focusColor: Colors.transparent,
        iconEnabledColor: Colors.black,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(8),
        ),
        value: value,
        selectedItemBuilder: (context) => items
            .map<DropdownMenuItem>(
              (e) => DropdownMenuItem(
                value: e,
                child: SizedBox(
                  width: width,
                  child: Text(
                    e == 'Tous' ? hint : e,
                    overflow: TextOverflow.clip,
                    style: normalTextStyle.copyWith(
                      color: e == 'Tous' ? darkGreyColor : blackColor,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        items: items
            .map<DropdownMenuItem>(
              (e) => DropdownMenuItem(
                value: e,
                child: SizedBox(
                  width: width,
                  child: Text(
                    e,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
