import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/screens/introduction_1.dart';
import 'package:ballwizard/types.dart'
    show
        AppBarVariant,
        ColorPalette,
        FundamentalVariant,
        RegistrationState,
        Toast,
        ToastVariant,
        Variant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

import '../state/toast.dart';
import '../toast.dart';

class Register extends StatelessWidget {
  bool renderNavbar;

  Register({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterPage(renderNavbar: renderNavbar);
  }
}

class RegisterPage extends StatefulWidget {
  bool renderNavbar;

  RegisterPage({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();
  String email = "";
  String password = "";
  String username = "";

  @override
  Widget build(BuildContext context) {
    bool canPass = (password == "" ||
        password.length < 8 ||
        password.length > 32 ||
        username == "" ||
        username.length > 32 ||
        username.length < 4 ||
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
                    "Register",
                    style: Fonts.addShadow(Fonts.heading
                        .merge(TextStyle(color: ColorPalette.light))),
                  ),
                ),
              ),
              Column(
                children: [
                  Form1.Input(
                    placeholder: "Enter username",
                    label: "Username",
                    variant: FundamentalVariant.light,
                    onChange: (val) {
                      setState(() {
                        username = val;
                      });
                    },
                    validator: (String val) {
                      if (val == "") return true;
                      if (val.length > 32 || val.length < 4) return false;
                      return true;
                    },
                  ),
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
                        variant: (canPass) ? Variant.muted : Variant.primary,
                        onClick: canPass
                            ? () {}
                            : () async {
                                final UserCredential cred = (await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password));
                                if (cred.user == null) {
                                  queue.add(Toast(
                                      variant: ToastVariant.error,
                                      value:
                                          "An error occurred! Please try again in a few minutes."));
                                  return;
                                }

                                final CollectionReference ref =
                                    FirebaseFirestore.instance
                                        .collection("user_info");

                                await ref.doc(cred.user?.uid).set({
                                  "registration_state",
                                  RegistrationState.incomplete.code()
                                });

                                await cred.user?.updateDisplayName(username);

                                await ref.doc(cred.user?.uid).update({
                                  "registration_state": RegistrationState
                                      .completeWithoutIntroduction
                                      .code()
                                });

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Introduction(),
                                  ),
                                );
                              },
                        title: "Register",
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
                      GestureDetector(
                        onTap: () async {
                          GoogleSignInAccount? user =
                              await GoogleSignIn().signIn();
                          GoogleSignInAuthentication? auth =
                              await user?.authentication;
                          AuthCredential creds = GoogleAuthProvider.credential(
                            //accessToken: auth?.accessToken,
                            idToken: auth?.idToken,
                            accessToken: auth?.accessToken,
                          );
                          UserCredential user_instance = await FirebaseAuth
                              .instance
                              .signInWithCredential(creds);
                          print(user_instance.user?.displayName!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: ColorPalette.light,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                              child: Image.asset(
                                'assets/google.png',
                                fit: BoxFit.contain,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          TwitterLogin login = new TwitterLogin(
                              apiKey: "mTUoE4QkhBqOnsEZ1G2f0w6ua",
                              apiSecretKey:
                                  "hpFkRcfe7aqD86utxOBn7zYAl1TPhQknevrygnnHNhWTH0R2z3",
                              redirectURI:
                                  "https://ballwizard-app.firebaseapp.com/__/auth/handler");
                          AuthResult auth = await login.login();

                          OAuthCredential creds =
                              TwitterAuthProvider.credential(
                                  accessToken: auth.authToken!,
                                  secret: auth.authTokenSecret!);

                          UserCredential user = await FirebaseAuth.instance
                              .signInWithCredential(creds);

                          print(user.user?.displayName!);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: ColorPalette.light,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              child: Image.asset(
                                'assets/apple.png',
                                fit: BoxFit.contain,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("click3");
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ColoredBox(
                            color: ColorPalette.light,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              child: Image.asset(
                                'assets/facebook.png',
                                fit: BoxFit.contain,
                                height: 48,
                              ),
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
