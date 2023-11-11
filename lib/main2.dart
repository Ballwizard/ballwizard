import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/main.dart' show MyHomePage;
import 'package:ballwizard/types.dart' show FundamentalVariant;
import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage2(title: 'Flutter Demo Home Pag123e');
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    onChange: (String text) {
                      print(text);
                    },
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.light)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
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
                child: Form1.Input(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark))
          ],
        ),
      ),
    );
  }
}
