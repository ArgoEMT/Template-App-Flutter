import 'package:flutter/material.dart';

import '../shared/colors.dart';

class CustomOutlinedDropdownButton<T> extends StatelessWidget {
  const CustomOutlinedDropdownButton({
    Key? key,
    this.isLoading = false,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isWhite = false,
  }) : super(key: key);

  final bool isLoading;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T? value)? onChanged;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color: isWhite ? whiteColor : blackColor.withOpacity(0.8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(4.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : DropdownButton(
                iconEnabledColor: isWhite ? whiteColor : blackColor,
                underline: Container(),
                dropdownColor: isWhite ? blackColor : whiteColor,
                focusColor: Colors.transparent,
                value: value,
                items: items,
                onChanged: onChanged,
              ),
      ),
    );
  }
}
