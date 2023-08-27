import 'package:flutter/material.dart';

Widget DrawerElement(
    {required String title,
    required Icon icon,
    required StatelessWidget component,
    required BuildContext context,
    isSelected = false}) {
  return ListTile(
    title: Row(children: [Text(title), icon]),
    selected: isSelected,
    onTap: () {
      Navigator.pop(context);
    },
  );
}
