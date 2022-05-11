import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../shared/colors.dart';
import '../shared/text_styles.dart';
import 'boutons/custom_text_button.dart';

///
/// Créé une snackbar custom.
///
void showSnackbar({
  required BuildContext context,
  required String titre,
  bool isErrorSnackbar = false,
  void Function()? onPressedAnnuler,
  void Function()? onDismiss,
  String? cancelLabel,
  double width = 345,
}) async {
  showToastWidget(
    Container(
      margin: const EdgeInsets.only(
        left: 329,
      ),
      width: width,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isErrorSnackbar ? errorColor : blackColor,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 14,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              titre,
              style: smallTextStyle.copyWith(color: whiteColor),
              overflow: TextOverflow.clip,
            ),
          ),
          if (onPressedAnnuler != null)
            CustomTextButton(
              onPressed: onPressedAnnuler,
              child: Text(
                cancelLabel ?? 'Annuler',
                style: const TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
        ],
      ),
    ),
    handleTouch: true,
    position: const ToastPosition(align: Alignment.bottomLeft, offset: -30),
    dismissOtherToast: true,
    duration: const Duration(seconds: 6),
    onDismiss: onDismiss,
  );
}
