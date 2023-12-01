import 'package:ballwizard/button.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart' as Globals;
import 'package:ballwizard/screens/introduction_2.dart';
import 'package:ballwizard/types.dart'
    show AppBarVariant, ColorPalette, FundamentalVariant, Variant;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String name = "";
  String day = "";
  String month = "";
  String year = "";

  List<bool> canPass = [false, false, false, false];
  bool pass = false;

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("display_name", name);
    prefs.setStringList("date_of_birth", [day, month, year]);
  }

  @override
  Widget build(BuildContext context) {
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
                          name = val;
                          if (val != "") {
                            bool _pass = true;
                            for (bool element in canPass) {
                              if (!element) {
                                _pass = false;
                                break;
                              }
                            }
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                pass = _pass;
                                canPass[0] = true;
                              });
                            });
                          }
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
                                  limit: 2,
                                  type: TextInputType.number,
                                  placeholder: "DD",
                                  validator: (val) {
                                    if (val == "") return true;
                                    int? test = int.tryParse(val);
                                    if (test == null) return false;
                                    if (test < 1 || test > 31) return false;
                                    if (month != "" && year != "") {
                                      try {
                                        DateTime? date =
                                            DateFormat("dd.MM.yyyy")
                                                .parseStrict(val
                                                        .toString()
                                                        .padLeft(2, "0") +
                                                    "." +
                                                    month
                                                        .toString()
                                                        .padLeft(2, "0") +
                                                    "." +
                                                    year.toString());
                                        if (date == null) return false;
                                        if (DateTime.now().isBefore(date))
                                          return false;
                                      } catch (err) {
                                        print(err);
                                        return false;
                                      }
                                    }
                                    canPass[1] = true;
                                    bool _pass = true;
                                    for (bool element in canPass) {
                                      if (!element) {
                                        _pass = false;
                                        break;
                                      }
                                    }
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        pass = _pass;
                                        canPass[1] = true;
                                      });
                                    });
                                    return true;
                                  },
                                  label: "Birth date",
                                  onChange: (val) {
                                    setState(() {
                                      day = val;
                                      canPass[1] = false;
                                    });
                                  }),
                            ),
                            Flexible(
                              child: Input(
                                  limit: 2,
                                  type: TextInputType.number,
                                  placeholder: "MM",
                                  validator: (val) {
                                    if (val == "") return true;
                                    int? test = int.tryParse(val);
                                    if (test == null) return false;
                                    if (test > 12 || test < 1) return false;
                                    if (day != "" && year != "") {
                                      try {
                                        DateTime? date =
                                            DateFormat("dd.MM.yyyy")
                                                .parseStrict(day
                                                        .toString()
                                                        .padLeft(2, "0") +
                                                    "." +
                                                    val
                                                        .toString()
                                                        .padLeft(2, "0") +
                                                    "." +
                                                    year.toString());
                                        if (date == null) return false;
                                        if (DateTime.now().isBefore(date))
                                          return false;
                                      } catch (err) {
                                        print(err);
                                        return false;
                                      }
                                    }
                                    canPass[2] = true;
                                    bool _pass = true;
                                    for (bool element in canPass) {
                                      if (!element) {
                                        _pass = false;
                                        break;
                                      }
                                    }
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        pass = _pass;
                                        canPass[2] = true;
                                      });
                                    });
                                    return true;
                                  },
                                  onChange: (val) {
                                    setState(() {
                                      month = val;
                                      canPass[2] = false;
                                      print("we done kicked them out")
                                    });
                                  }),
                            )
                          ],
                        )),
                        Flexible(
                          child: Input(
                              limit: 4,
                              type: TextInputType.number,
                              placeholder: "YYYY",
                              validator: (val) {
                                if (val == "") return true;
                                int? test = int.tryParse(val);
                                if (test == null) return false;
                                if (test > 2025 || test < 1900) return false;
                                if (day != "" && month != "") {
                                  try {
                                    DateTime? date = DateFormat("dd.MM.yyyy")
                                        .parseStrict(day
                                                .toString()
                                                .padLeft(2, "0") +
                                            "." +
                                            month.toString().padLeft(2, "0") +
                                            "." +
                                            val.toString());
                                    if (date == null) return false;
                                    if (DateTime.now().isBefore(date))
                                      return false;
                                  } catch (err) {
                                    return false;
                                  }
                                }
                                canPass[3] = true;
                                bool _pass = true;
                                for (bool element in canPass) {
                                  if (!element) {
                                    _pass = false;
                                    break;
                                  }
                                }
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    pass = _pass;
                                    canPass[3] = true;
                                  });
                                });
                                return true;
                              },
                              onChange: (val) {
                                setState(() {
                                  year = val;
                                  canPass[3] = false;
                                });
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Globals.ShadowElement(
                child: Button(
                  onClick: pass
                      ? () {
                          saveData();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Introduction2(),
                            ),
                          );
                        }
                      : () {},
                  title: "Continue",
                  variant: pass ? Variant.primary : Variant.muted,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
