import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/button.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../state/toast.dart';
import '../toast.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) => Feedback();
}

class Feedback extends StatefulWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();
  String content = "";

  Feedback({super.key});

  @override
  State<StatefulWidget> createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Start()),
        );
      });
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarCustom(
            key: widget._key, context: context, type: AppBarVariant.arrow),
        bottomSheet: ListenableBuilder(
          listenable: widget.queue,
          builder: (BuildContext context, Widget? child) {
            if (widget.queue.current != null) {
              return ToastComponent(toast: widget.queue.current!);
            }
            return const SizedBox();
          },
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Send feedback",
                    style: Fonts.large,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Feedback is very important to us. If you'd be kind enough to share your "
                    "experience with our app that would be great and would help us make the app better.",
                    style: Fonts.smallLight,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: TextField(
                      onChanged: (val) {
                        widget.content = val;
                      },
                      minLines: 5,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: ColorPalette.dark)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: ColorPalette.dark)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: ColorPalette.dark)),
                        focusColor: ColorPalette.dark,
                      ),
                    ),
                  ),
                  Button(
                    onClick: widget.content == ""
                        ? () {}
                        : () async {
                            try {
                              final doc = FirebaseFirestore.instance
                                  .collection("feedback")
                                  .doc(FirebaseAuth.instance.currentUser!.uid);

                              await doc.set({
                                "content": widget.content,
                                "time_of_sending": DateTime.now(),
                                "uuid": FirebaseAuth.instance.currentUser!.uid
                              });
                            } catch (e) {
                              widget.queue.add(Toast(
                                  variant: ToastVariant.error,
                                  value:
                                      "An error occurred! Please try again in a few minutes."));
                            }
                          },
                    title: "Send feedback",
                    variant:
                        widget.content == "" ? Variant.muted : Variant.dark,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
