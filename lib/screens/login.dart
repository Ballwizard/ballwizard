import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Form;
import 'package:ballwizard/main.dart' show MyHomePage;
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  bool renderNavbar;

  Login({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage(renderNavbar: renderNavbar);
  }
}

class LoginPage extends StatefulWidget {
  bool renderNavbar;

  LoginPage({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: widget.renderNavbar
          ? AppBarCustom(
              type: AppBarVariant.arrowLogo, key: _key, context: context)
          : null,
      endDrawer: DrawerCustom(context: context),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              36, 36 + 54 + MediaQuery.of(context).viewPadding.top, 36, 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 64),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Login",
                    style: Fonts.heading
                        .merge(TextStyle(color: ColorPalette.light)),
                  ),
                ),
              ),
              Column(
                children: [
                  Form1.Form(
                      placeholder: "Enter username",
                      label: "Username",
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
                    title: "test",
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
            ],
          ),
        ),
      ),
    );
  }
}
