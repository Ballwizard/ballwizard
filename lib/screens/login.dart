import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/types.dart'
    show
        AppBarVariant,
        ColorPalette,
        FundamentalVariant,
        Toast,
        ToastVariant,
        Variant;
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../state/toast.dart';
import '../toast.dart';

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
  final ToastQueue queue = ToastQueue();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    bool canPass = (password == "" ||
        password.length < 8 ||
        password.length > 32 ||
        email == "" ||
        !EmailValidator.validate(email));
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: widget.renderNavbar
          ? AppBarCustom(
              type: AppBarVariant.arrow,
              key: _key,
              context: context,
              isTransparent: true,
              variant: FundamentalVariant.dark)
          : null,
      bottomSheet: ListenableBuilder(
        listenable: queue,
        builder: (BuildContext context, Widget? child) {
          if (queue.current != null) {
            return ToastComponent(toast: queue.current!);
          }
          return SizedBox();
        },
      ),
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
                    style: Fonts.addShadow(Fonts.heading
                        .merge(TextStyle(color: ColorPalette.light))),
                  ),
                ),
              ),
              Column(
                children: [
                  Form1.Input(
                    placeholder: "Enter email",
                    label: "Email",
                    variant: FundamentalVariant.light,
                    onChange: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (String val) {
                      if (val == "") return true;
                      if (!EmailValidator.validate(val)) return false;
                      return true;
                    },
                  ),
                  Form1.Input(
                    placeholder: "Enter password",
                    label: "Password",
                    variant: FundamentalVariant.light,
                    onChange: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    isPassword: true,
                    validator: (String val) {
                      if (val == "") return true;
                      if (val.length < 8 || val.length > 32) return false;
                      return true;
                    },
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.03,
                    child: ShadowElement(
                      child: Button(
                        variant: canPass ? Variant.muted : Variant.primary,
                        onClick: canPass
                            ? () {}
                            : () async {
                                try {
                                  UserCredential cred = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  print(e.code);
                                  if (e.code == "invalid-credential") {
                                    queue.add(Toast(
                                        variant: ToastVariant.error,
                                        value:
                                            "Invalid email/password combination."));
                                    return;
                                  } else {
                                    queue.add(Toast(
                                        variant: ToastVariant.error,
                                        value:
                                            "An error occurred! Please try again in a few minutes."));
                                    return;
                                  }
                                }
                              },
                        title: "Login",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            child: SizedBox(
                                height: 2,
                                child: ColoredBox(color: ColorPalette.light)),
                            widthFactor: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Or continue with",
                              style: Fonts.sm
                                  .merge(TextStyle(color: ColorPalette.light))),
                        ),
                        Flexible(
                          child: FractionallySizedBox(
                            child: SizedBox(
                                height: 2,
                                child: ColoredBox(color: ColorPalette.light)),
                            widthFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i in [
                        'assets/google.png',
                        'assets/apple.png',
                        'assets/facebook.png'
                      ])
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: ColorPalette.light,
                            child: Padding(
                              padding: i == 'assets/google.png'
                                  ? EdgeInsets.fromLTRB(16, 12, 16, 4)
                                  : EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                              child: Image.asset(
                                i,
                                fit: BoxFit.contain,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
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
