import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

Widget DrawerElement(
    {required String title,
    Icon icon = const Icon(
      Icons.account_circle,
      size: 34,
      color: ColorPalette.dark,
    ),
    required StatelessWidget component,
    required BuildContext context,
    Image? picture,
    Color color = ColorPalette.light,
    Color textColor = ColorPalette.dark,
    isSelected = false}) {
  return ListTile(
    tileColor: color,
    title: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      child: Row(
        children: [
          Text(title, style: Fonts.small.merge(TextStyle(color: textColor))),
          picture != null
              ? ClipRRect(
                  child: picture,
                  borderRadius: BorderRadius.circular(48),
                )
              : icon
        ],
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
