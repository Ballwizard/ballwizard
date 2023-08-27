import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

PreferredSizeWidget AppBarCustom(
    {FundamentalVariant variant = FundamentalVariant.light,
    FundamentalVariant titleVariant = FundamentalVariant.dark,
    String title = "",
    bool isTransparent = false,
    AppBarVariant type = AppBarVariant.arrow,
    required GlobalKey<ScaffoldState> key}) {
  switch (type) {
    case AppBarVariant.arrow:
      return AppBar(
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
        elevation: 0,
      );
    case AppBarVariant.logoPicture:
      return AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            'assets/logofb.png',
            fit: BoxFit.contain,
            height: 48,
          ),
          const SizedBox(
            height: 48,
            width: 48,
            child: ColoredBox(color: ColorPalette.dark),
          )
        ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
        elevation: 0,
      );
    case AppBarVariant.arrowLogoPicture:
      return AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Row(
            // this is the only way that I found to manage to center the logo, I know it's not the best, welp :(
            children: [
              Icon(Icons.arrow_back, color: ColorPalette.dark),
              SizedBox(width: 16)
            ],
          ),
          Image.asset(
            'assets/logofb.png',
            fit: BoxFit.contain,
            height: 48,
          ),
          IconButton(
              onPressed: () {
                print(key);
                print(key.currentState);
                print(key.currentState?.openDrawer);
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.arrow_back)),
        ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
        elevation: 0,
      );
    default:
      return AppBar();
  }
}

/*
return AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          width: 285,
        ),
        const SizedBox(
          height: 64,
          width: 64,
          child: ColoredBox(color: ColorPalette.dark),
        )
      ]),
      backgroundColor:
          widget.isTransparent ? Colors.transparent : widget.variant.color(),
      foregroundColor: widget.titleVariant.color(),
      elevation: 0,
    );
 */

// arrow, logoPicture, arrowLogo, arrowLogoPicture, search
