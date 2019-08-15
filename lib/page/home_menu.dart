
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/constant/home_menu_items.dart';
import 'package:flutter_package/flutter_widget_compat.dart';

class HomeMenu {
  HomeMenu(this.context);

  final BuildContext context;

  Widget buildButton() {
    final actionSelected = (int value) {

    };
    if (isMaterial) {
      return _buildMaterialMenu(actionSelected);
    } else {
      return _buildCupertinoMenu(actionSelected);
    }
  }

  Widget _buildMaterialMenu(PopupMenuItemSelected<int> onAction) {
    final convert = (MenuItem item) => PopupMenuItem<int>(
      value: item.menuKey,
      child: Text(item.title),
    );
    final menuList = homeMenuList.map(convert).toList();

    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => menuList,
      onSelected: onAction,
    );
  }

  Widget _buildCupertinoMenu(PopupMenuItemSelected<int> onAction) {
    final convert = (MenuItem item) => CupertinoActionSheetAction(
      onPressed: () {
        onAction(item.menuKey);
        Navigator.pop(context, item.menuKey);
      },
      child: Text(item.title),
    );
    final actionList = homeMenuList.map(convert).toList();

    return CompatIconButton(
      cupertinoIcon: Icon(CupertinoIcons.ellipsis),
      onPressed: () {
        showCupertinoModalPopup<int>(context: context, builder:(context) {
          return CupertinoActionSheet(
            actions: actionList,
            cancelButton: convert(cancelMenu),
          );
        });
      },
    );
  }

  static HomeMenu of(BuildContext context) {
    return HomeMenu(context);
  }
}