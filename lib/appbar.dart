import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input.dart';

PreferredSizeWidget AppBarCustom(
    {FundamentalVariant variant = FundamentalVariant.light,
    FundamentalVariant titleVariant = FundamentalVariant.dark,
    String title = "",
    bool isTransparent = false,
    AppBarVariant type = AppBarVariant.arrow,
    String placeholder = "",
    onInputChange,
    onEnter,
    required GlobalKey<ScaffoldState> key,
    required BuildContext context}) {
  switch (type) {
    case AppBarVariant.arrow:
      return AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButton(variant, context),
            ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        elevation: 0,
        foregroundColor: titleVariant.color(),
      );
    case AppBarVariant.logoPicture:
      return AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.asset(
            'assets/logofb.png',
            fit: BoxFit.contain,
            height: 48,
          ),
          GestureDetector(
            onTap: () {
              key.currentState?.openEndDrawer();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: FirebaseAuth.instance.currentUser?.photoURL != null
                  ? Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL!,
                      width: 34,
                      height: 34,
                    )
                  : Icon(Icons.account_circle, size: 34),
            ),
          ),
        ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
      );
    case AppBarVariant.arrowLogo:
      return AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButton(variant, context),
              Image.asset(
                'assets/logofb.png',
                fit: BoxFit.contain,
                height: 48,
              ),
              const SizedBox(
                width: 48,
              )
            ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
      );
    case AppBarVariant.arrowLogoPicture:
      return AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButton(variant, context),
              Image.asset(
                'assets/logofb.png',
                fit: BoxFit.contain,
                height: 48,
              ),
              AccountButton(variant, key)
            ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
      );
    case AppBarVariant.search:
      return AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[Container()],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: SizedBox(
                      height: 75,
                      child: FractionallySizedBox(
                        widthFactor: 1.03,
                        child: Input(
                          onChange: onInputChange ?? (String val) {},
                          onEnter: onEnter ?? (String val) {},
                          placeholder: placeholder,
                        ),
                      ))),
            ]),
        backgroundColor: isTransparent ? Colors.transparent : variant.color(),
        foregroundColor: titleVariant.color(),
      );
    default:
      return AppBar();
  }
}

Widget BackButton(FundamentalVariant variant, BuildContext context) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back, color: variant.inverseColor(), size: 32));
}

Widget AccountButton(FundamentalVariant variant, GlobalKey<ScaffoldState> key) {
  return IconButton(
      onPressed: () {
        key.currentState?.openEndDrawer();
      },
      icon:
          Icon(Icons.account_circle, size: 34, color: variant.inverseColor()));
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
