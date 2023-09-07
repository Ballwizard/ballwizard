import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Form;
import 'package:ballwizard/main.dart' show MyHomePage;
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: AppBarCustom(
          type: AppBarVariant.arrowLogo, key: _key, context: context),
      endDrawer: DrawerCustom(context: context),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register",
                  style:
                      Fonts.heading.merge(TextStyle(color: ColorPalette.light)),
                ),
              ),
              Column(
                children: [
                  Form1.Form(
                      placeholder: "Enter username",
                      label: "Username",
                      variant: FundamentalVariant.light),
                  Form1.Form(
                      placeholder: "Enter email",
                      label: "Email",
                      variant: FundamentalVariant.light),
                  Form1.Form(
                      placeholder: "Enter password",
                      label: "Password",
                      variant: FundamentalVariant.light),
                  Button(
                    variant: FundamentalVariant.dark,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: "hello"),
                        ),
                      );
                    },
                    title: "Register",
                  ),
                ],
              ),
              Text("Or continue with"),
              Row(
                children: [
                  Text("test1"),
                  Text("test2"),
                  Text("test3"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
