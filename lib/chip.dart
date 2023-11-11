import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

Widget ChipElement(
    {required String text, required Variant variant, bool isSelected = false}) {
  Color textColor = [
    Variant.light,
    Variant.lightMuted,
    Variant.warning,
    Variant.warningMuted,
    Variant.success,
    Variant.successMuted
  ].contains(variant)
      ? ColorPalette.dark
      : ColorPalette.light;

  return Container(
    decoration: isSelected
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 2, color: ColorPalette.light),
            boxShadow: [
                BoxShadow(
                  color: ColorPalette.light,
                  spreadRadius: 0,
                  blurRadius: 4,
                )
              ])
        : BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
            BoxShadow(
              color: ColorPalette.dark,
              spreadRadius: 0,
              blurRadius: 2,
            )
          ]),
    child: ClipRRect(
      borderRadius:
          isSelected ? BorderRadius.circular(16) : BorderRadius.circular(16),
      child: ColoredBox(
          color: variant.color(),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Text(text,
                  style: isSelected
                      ? Fonts.small.merge(TextStyle(
                          color: (variant != Variant.light &&
                                  variant != Variant.light)
                              ? ColorPalette.light
                              : textColor))
                      : Fonts.small.merge(TextStyle(color: textColor))))),
    ),
  );
}
