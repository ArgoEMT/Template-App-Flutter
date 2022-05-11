import 'package:flutter/material.dart';

class MenuItem {
  ///
  /// Support les [IconData] et les [ImageIcon].
  final IconData icon;
  final String libelle;
  final Function? action;
  final List<MenuItem>? subMenu;
  final List<String> routePaths;

  /// Bool qui indique si le bouton est activé ou non.
  final bool isEnable;

  MenuItem({
    required this.icon,
    required this.libelle,
    required this.routePaths,
    this.action,
    this.subMenu,
    this.isEnable = true,
  });
}
