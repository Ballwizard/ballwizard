import 'package:ballwizard/card.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  const MainList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: FractionallySizedBox(
          heightFactor: 1,
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: CardElement(
                      title: "breathe in the air",
                      views: 93213,
                      dateOfCreation: DateTime.timestamp()),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: CardElement(
                      title: "breathe in the air",
                      views: 93213,
                      dateOfCreation: DateTime.timestamp()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
