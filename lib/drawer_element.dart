import 'package:ballwizard/globals.dart';
import 'package:flutter/material.dart';

Widget DrawerElement(
    {required String title,
    required Icon icon,
    required StatelessWidget component,
    required BuildContext context,
    isSelected = false}) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      child: Row(
        children: [Text(title, style: Fonts.small), icon],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    ),
    selected: isSelected,
    onTap: () {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => component,
        ),
      );
    },
  );
}
