import 'package:ballwizard/button.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Modal extends StatefulWidget {
  final bool showModal;
  final Function(bool) toggleModal;
  const Modal({super.key, required this.showModal, required this.toggleModal});

  @override
  State<Modal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Modal> {
  Widget ButtonWidget(String text, func, isRed) {
    return SizedBox(
      width: 80,
      height: 40,
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
            backgroundColor: isRed ? ColorPalette.danger : ColorPalette.muted,
            foregroundColor: ColorPalette.light),
        child: Text(text),
      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  Future<void> deleteAccount() async {
    try {
      await user?.delete();
      Navigator.of(context).pushNamedAndRemoveUntil('/intro', (route) => false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: ColorPalette.dark),
      child: Container(
        color: const Color(0xF0808080),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorPalette.light),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to delete your account?',
                    style: Fonts.medium,
                    textAlign: TextAlign.center,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Button(
                                onClick: () async => deleteAccount(),
                                variant: Variant.danger,
                                title: "Yes",
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Button(
                                onClick: () {
                                  widget.toggleModal(false);
                                },
                                variant: Variant.muted,
                                title: "No",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
