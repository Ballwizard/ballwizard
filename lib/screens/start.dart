import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Form;
import 'package:ballwizard/main.dart' show MyHomePage;
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  bool renderNavbar;

  Start({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartPage();
  }
}

class StartPage extends StatefulWidget {
  bool renderNavbar;

  StartPage({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  State<StartPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StartPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: widget.renderNavbar
          ? AppBarCustom(
              type: AppBarVariant.arrowLogoPicture, key: _key, context: context)
          : null,
      endDrawer: DrawerCustom(context: context),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Form(
                    onChange: (String text) {
                      print(text);
                    },
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.light)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Form(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.light)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: "hello"),
                      ),
                    );
                  },
                  title: "test",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    Navigator.pop(context);
                  },
                  title: "test",
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Form(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Form(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark))
          ],
        ),
      ),
    );
  }
}
