import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/button.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart' as Globals;
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/types.dart'
    show AppBarVariant, ColorPalette, FundamentalVariant, Variant;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chip.dart';

class Introduction2 extends StatelessWidget {
  const Introduction2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Introduction2Page();
  }
}

class Introduction2Page extends StatefulWidget {
  const Introduction2Page({Key? key}) : super(key: key);

  @override
  State<Introduction2Page> createState() => Introduction2PageState();
}

class Introduction2PageState extends State<Introduction2Page> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currIndex = -1;
  List<bool> selected = List<bool>.generate(6, (index) => false);

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "skill_level",
        currIndex == 1
            ? "beginner"
            : currIndex == 2
                ? "Intermediate"
                : "Professional");
    prefs.setStringList(
        "date_of_birth",
        List<String>.generate(
            6, (index) => selected[index] ? "true" : "false"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: AppBarCustom(
          key: _key,
          context: context,
          type: AppBarVariant.arrow,
          variant: FundamentalVariant.dark,
          isTransparent: true),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 64),
                      child: Text(
                        "Tell us more about yourself",
                        style: Globals.Fonts.addShadow(Globals.Fonts.heading
                            .merge(TextStyle(color: ColorPalette.light))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text("Skill level",
                          style: Globals.Fonts.addShadow(Globals.Fonts.sm
                              .merge(TextStyle(color: ColorPalette.light)))),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currIndex == 0)
                                  currIndex = -1;
                                else
                                  currIndex = 0;
                              });
                            },
                            child: ChipElement(
                                text: "Begginer",
                                variant: Variant.success,
                                isSelected: currIndex == 0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currIndex == 1)
                                  currIndex = -1;
                                else
                                  currIndex = 1;
                              });
                            },
                            child: ChipElement(
                                text: "Intermediate",
                                variant: Variant.warning,
                                isSelected: currIndex == 1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currIndex == 2)
                                  currIndex = -1;
                                else
                                  currIndex = 2;
                              });
                            },
                            child: ChipElement(
                                text: "Professional",
                                variant: Variant.danger,
                                isSelected: currIndex == 2),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text("What do you want to improve?",
                          style: Globals.Fonts.addShadow(Globals.Fonts.sm
                              .merge(TextStyle(color: ColorPalette.light)))),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[0] == true)
                                  selected[0] = false;
                                else
                                  selected[0] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Shooting",
                                variant: Variant.light,
                                isSelected: selected[0]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[1] == true)
                                  selected[1] = false;
                                else
                                  selected[1] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Dribbling",
                                variant: Variant.light,
                                isSelected: selected[1]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[2] == true)
                                  selected[2] = false;
                                else
                                  selected[2] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Passing",
                                variant: Variant.light,
                                isSelected: selected[2]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[3] == true)
                                  selected[3] = false;
                                else
                                  selected[3] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Ball control",
                                variant: Variant.light,
                                isSelected: selected[3]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[4] == true)
                                  selected[4] = false;
                                else
                                  selected[4] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Playmaking",
                                variant: Variant.light,
                                isSelected: selected[4]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 6),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected[5] == true)
                                  selected[5] = false;
                                else
                                  selected[5] = true;
                              });
                            },
                            child: ChipElement(
                                text: "Court-awareness",
                                variant: Variant.light,
                                isSelected: selected[5]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Globals.ShadowElement(
                child: Button(
                  onClick: currIndex != -1 &&
                          (selected.where((e) => e == true).toList()).isNotEmpty
                      ? () {
                          saveData();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        }
                      : () {},
                  title: "Continue",
                  variant: currIndex != -1 &&
                          (selected.where((e) => e == true).toList()).isNotEmpty
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
