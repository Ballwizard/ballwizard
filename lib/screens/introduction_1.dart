import 'package:ballwizard/button.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart' as Globals;
import 'package:ballwizard/screens/introduction_2.dart';
import 'package:ballwizard/types.dart'
    show AppBarVariant, ColorPalette, FundamentalVariant, Variant;
import 'package:flutter/material.dart';

import '../input.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IntroductionPage();
  }
}

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String? name;
    String? day;
    String? month;
    String? year;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: null,
      endDrawer: DrawerCustom(context: context),
      body: Globals.GradientBackground(
        variant: FundamentalVariant.light,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 64),
                      child: Text("Tell us more about yourself",
                          style: Globals.Fonts.addShadow(Globals.Fonts.heading
                              .merge(TextStyle(color: ColorPalette.light)))),
                    ),
                    Input(
                      placeholder: "Enter your name",
                      label: "Your name",
                      onChange: (val) {
                        setState(() {
                          year = val;
                          month = month;
                          name = name;
                          day = day;
                          print(name);
                          print(day);
                          print(month);
                          print(year);
                        });
                      },
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Row(
                          children: [
                            Flexible(
                              child: Input(
                                  placeholder: "DD",
                                  label: "Birth date",
                                  onChange: (val) {
                                    setState(() {
                                      year = val;
                                      month = month;
                                      name = name;
                                      day = day;
                                    });
                                  }),
                            ),
                            Flexible(
                              child: Input(
                                  placeholder: "MM",
                                  onChange: (val) {
                                    setState(() {
                                      year = val;
                                      month = month;
                                      name = name;
                                      day = day;
                                    });
                                  }),
                            )
                          ],
                        )),
                        Flexible(
                          child: Input(
                              placeholder: "YYYY",
                              onChange: (val) {
                                setState(() {
                                  year = val;
                                  month = month;
                                  name = name;
                                  day = day;
                                });
                                print(name);
                                print(day);
                                print(month);
                                print(year);
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Globals.Shadow(
                child: Button(
                  onClick: (name != null &&
                          day != null &&
                          month != null &&
                          year != null)
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Introduction2(),
                            ),
                          );
                        }
                      : () {},
                  title: "Continue",
                  variant: (name != null &&
                          day != null &&
                          month != null &&
                          year != null)
                      ? Variant.primary
                      : Variant.muted,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
