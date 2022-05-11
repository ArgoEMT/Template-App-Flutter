import 'package:flutter/material.dart';

import '../shared/colors.dart';
import '../shared/text_styles.dart';
import 'boutons/custom_text_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.title,
    this.body,
    this.okButtonLabel,
    this.okButtonAction,
    this.showOkButton = true,
    this.popOnAction = true,
    this.cancelButtonLabel,
    this.cancelButtonAction,
    this.textSpacing = 15,
    this.elementWidth = 330,
    this.elevation = 24,
  }) : super(key: key);
  final bool popOnAction;
  final dynamic title;
  final List<dynamic>? body;
  final String? okButtonLabel;
  final Function? okButtonAction;
  final bool showOkButton;
  final String? cancelButtonLabel;
  final Function? cancelButtonAction;
  final double textSpacing;
  final double elementWidth;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    var effectiveTitle = title is String ? Text(title) : title;

    var columnItems = <Widget>[];
    if (body != null) {
      body?.forEach(
        (element) {
          columnItems.add(
            Column(
              children: [
                SizedBox(height: textSpacing),
                element is String
                    ? SizedBox(
                        width: elementWidth,
                        child: Text(
                          element,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: elementWidth,
                        child: element,
                      ),
              ],
            ),
          );
        },
      );
    }
    return SimpleDialog(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: effectiveTitle,
      titleTextStyle: const TextStyle(
        color: blackColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      children: [
        /// Création body
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnItems,
        ),
        const SizedBox(height: 25),

        ///Création boutons
        Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (cancelButtonLabel != null && cancelButtonLabel!.isNotEmpty)
              CustomTextButton(
                onPressed: () {
                  if (popOnAction || cancelButtonAction == null) {
                    Navigator.of(context).pop();
                  }
                  if (cancelButtonAction != null) {
                    cancelButtonAction!();
                  }
                },
                child: Text(
                  cancelButtonLabel!,
                  style: normalTextStyle.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            if (showOkButton) SizedBox(width: textSpacing),
            if (showOkButton)
              CustomTextButton(
                onPressed: () {
                  if (popOnAction) {
                    Navigator.of(context).pop();
                  }
                  if (okButtonAction != null) {
                    okButtonAction!();
                  }
                },
                child: Text(
                  okButtonLabel ?? 'Ok',
                  style: normalTextStyle.copyWith(
                    color: secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
