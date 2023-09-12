import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Form;
import 'package:ballwizard/main.dart' show MyHomePage;
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

class MainList extends StatelessWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainListPage();
  }
}

class MainListPage extends StatefulWidget {
  const MainListPage({Key? key}) : super(key: key);

  @override
  State<MainListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
