import 'package:flutter/material.dart';

AppBar MyAppBar({
  String title,
  bool centerTitle,
  bool backIcon,
  List<Widget> action,
}) {
  return AppBar(
    toolbarHeight: 70,
    automaticallyImplyLeading: backIcon ?? true,
    centerTitle: centerTitle ?? true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    actions: action,
  );
}