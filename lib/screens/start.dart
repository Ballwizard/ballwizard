// ignore_for_file: avoid_print

import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/login.dart';
import 'package:ballwizard/screens/register.dart';
import 'package:ballwizard/types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../state/toast.dart';
import '../toast.dart';

class Start extends StatelessWidget {
  bool renderNavbar;

  Start({super.key, this.renderNavbar = true});

  @override
  Widget build(BuildContext context) {
    return StartPage(
      renderNavbar: renderNavbar,
    );
  }
}

class StartPage extends StatefulWidget {
  bool renderNavbar;

  StartPage({super.key, this.renderNavbar = true});

  @override
  State<StartPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StartPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: null,
      endDrawer: DrawerCustom(context: context),
      bottomSheet: ListenableBuilder(
        listenable: queue,
        builder: (BuildContext context, Widget? child) {
          if (queue.current != null) {
            return AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 200),
                child: ToastComponent(toast: queue.current!));
          }
          return const SizedBox();
        },
      ),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.asset('assets/logo.png',
                    fit: BoxFit.contain, height: 128),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Button(
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Register()),
                      );
                    },
                    title: "Register"),
              ),
              Button(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Login()),
                    );
                  },
                  title: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}

/*
* ListenableBuilder(
              listenable: queue,
              builder: (BuildContext context, Widget? child) {
                print("yes");
                print(queue.current?.value);
                if (queue.current != null)
                  return ToastComponent(toast: queue.current!);
                return Container();
              },
            ),
* */
//       bottomSheet: Container(),
