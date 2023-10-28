import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Form;
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

import '../state/toast.dart';
import '../toast.dart';

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
  final ToastQueue queue = ToastQueue();

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
      bottomSheet: ListenableBuilder(
        listenable: queue,
        builder: (BuildContext context, Widget? child) {
          if (queue.current != null) {
            return AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 200),
                child: ToastComponent(toast: queue.current!));
          }
          return SizedBox();
        },
      ),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                    queue.add(
                        Toast(variant: ToastVariant.success, value: "omaga"));
                  },
                  title: "test",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    queue.add(
                        Toast(variant: ToastVariant.error, value: "omaga"));
                  },
                  title: "test",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    queue.add(
                        Toast(variant: ToastVariant.warning, value: "omaga"));
                  },
                  title: "test",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                  },
                  title: "test",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    queue.removeAll();
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
                    variant: FundamentalVariant.dark)),
          ],
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
