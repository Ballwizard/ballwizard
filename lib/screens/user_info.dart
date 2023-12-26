import 'dart:io';

import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart'
    show
        AppBarVariant,
        ColorPalette,
        FundamentalVariant,
        Toast,
        ToastVariant,
        Variant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../input.dart';
import '../state/toast.dart';
import '../toast.dart';

class UserInformation extends StatelessWidget {
  UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return UserInformationPage();
  }
}

class UserInformationPage extends StatefulWidget {
  UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => UserInformationPageState();
}

class UserInformationPageState extends State<UserInformationPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) Navigator.pop(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _key,
        appBar: AppBarCustom(
            type: AppBarVariant.arrow,
            key: _key,
            context: context,
            isTransparent: true),
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
        body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 64),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () async {
                        XFile? image = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 28);

                        if (image == null ||
                            FirebaseAuth.instance.currentUser == null) return;

                        Reference ref = FirebaseStorage.instance
                            .ref()
                            .child(FirebaseAuth.instance.currentUser!.uid!);

                        await ref.putFile(File(image!.path));
                        ref.getDownloadURL().then((value) => print(value));
                      },
                      child: FirebaseAuth.instance.currentUser!.photoURL != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(64)),
                              child: Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL!,
                                fit: BoxFit.fill,
                                width: 128,
                                height: 128,
                              ),
                            )
                          : Icon(Icons.account_circle, size: 128),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                FirebaseAuth.instance.currentUser!.displayName!,
                                style: Fonts.large,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                print("hello");
                              },
                              child: Icon(Icons.edit_rounded, size: 32))
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.75,
                    child: SizedBox(
                        height: 1, child: ColoredBox(color: ColorPalette.dark)),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Input(
                      placeholder: "New username",
                      label: "Change username",
                      labelVariant: FundamentalVariant.dark,
                    ),
                    Input(
                      placeholder: "New password",
                      label: "Change password",
                      labelVariant: FundamentalVariant.dark,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
