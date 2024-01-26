import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/content_page.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

Widget Headings(String _text,
    {bool condition = false, Color color = ColorPalette.light}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      _text,
      style: Fonts.heading.copyWith(
          color: color,
          decoration: condition ? TextDecoration.underline : null,
          decorationThickness: 1,
          decorationColor: ColorPalette.dark),
    ),
  );
}

Widget Content(context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContentPage(
                    creatorView: false,
                  )));
    },
    child: Padding(
      padding: EdgeInsets.only(right: 20, bottom: 20, top: 10),
      child: Row(children: [
        Container(
            decoration: const BoxDecoration(
              color: ColorPalette.dark,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 225,
            width: 300,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  height: 80,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: ColorPalette.light,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          'Russian Criss Cross',
                          style: Fonts.large.copyWith(
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "By • Ante Antić",
                                style: Fonts.smLight,
                              ),
                              const Icon(
                                Icons.favorite,
                                color: ColorPalette.mutedMuted,
                              )
                            ]),
                      ),
                    ],
                  )),
            ))
      ]),
    ),
  );
}

OutlineInputBorder textFormBorder(colorBorder) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1, color: colorBorder),
    borderRadius: BorderRadius.circular(8),
  );
}