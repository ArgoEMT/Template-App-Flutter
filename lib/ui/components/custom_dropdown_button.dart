import 'package:flutter/material.dart';

import '../shared/colors.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    Key? key,
    this.onChanged,
    required this.value,
    required this.items,
  }) : super(key: key);

  final Function(dynamic)? onChanged;
  final Object value;
  final List<DropdownMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: whiteColor,
      ),
      padding: const EdgeInsets.only(left: 8),
      child: DropdownButton(
        focusColor: Colors.transparent,
        iconEnabledColor: blackColor,
        underline: Container(),
        style: const TextStyle(
          color: blackColor,
          fontSize: 15,
        ),
        dropdownColor: whiteColor,
        value: value,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
