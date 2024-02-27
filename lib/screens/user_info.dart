// ignore_for_file: avoid_print

import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/manage_activity.dart';
import 'package:ballwizard/types.dart'
    show AppBarVariant, ColorPalette, FundamentalVariant, Variant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase.dart';
import '../input.dart';
import '../modal.dart';
import '../state/toast.dart';
import '../toast.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserInformationPage();
  }
}

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => UserInformationPageState();
}

class UserInformationPageState extends State<UserInformationPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();
  String username = "";
  String password = "";
  bool showModal = false;

  User? user = FirebaseAuth.instance.currentUser;
  Future<void> deleteAccount() async {
    try {
      await user?.delete();
      Navigator.of(context).pushNamedAndRemoveUntil('/intro', (route) => false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUsernameAndPassword() async {
    if (username != "" && username.length >= 4) {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    }

    if (password != "" && password.length >= 8) {
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
    }

    setState(() {});
  }

  void toggleModal(bool value) {
    setState(() {
      showModal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if (FirebaseAuth.instance.currentUser == null) Navigator.pop(context);

    return showModal
        ? Modal(
            showModal: showModal,
            toggleModal: toggleModal,
          )
        : Scaffold(
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
                return const SizedBox();
              },
            ),
            endDrawer: DrawerCustom(context: context),
            body: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 64),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: GestureDetector(
                                  onTap: () async {
                                    await chooseProfilePic();
                                    setState(() {
                                      displayPfpImg;
                                    });
                                  },
                                  child: FirebaseAuth
                                              .instance.currentUser!.photoURL !=
                                          null
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(64)),
                                          child: Image.network(
                                            FirebaseAuth.instance.currentUser!
                                                .photoURL!,
                                            fit: BoxFit.fill,
                                            width: 128,
                                            height: 128,
                                          ),
                                        )
                                      : const Icon(Icons.account_circle,
                                          size: 128),
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
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text(
                                            FirebaseAuth.instance.currentUser!
                                                .displayName!,
                                            style: Fonts.large,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const FractionallySizedBox(
                                widthFactor: 0.9,
                                child: SizedBox(
                                    height: 0.5,
                                    child:
                                        ColoredBox(color: ColorPalette.muted)),
                              ),
                            ],
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Input(
                                  onChange: (val) {
                                    setState(() {
                                      username = val;
                                    });
                                  },
                                  placeholder: "New username",
                                  label: "Change username",
                                  labelVariant: FundamentalVariant.dark,
                                ),
                                Input(
                                  onChange: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  placeholder: "New password",
                                  label: "Change password",
                                  labelVariant: FundamentalVariant.dark,
                                  isPassword: true,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: FractionallySizedBox(
                                    widthFactor: 1,
                                    child: SizedBox(
                                        height: 0.5,
                                        child: ColoredBox(
                                            color: ColorPalette.muted)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const ManageActivity(),
                                    ));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.open_in_new,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          "Manage activity",
                                          style: Fonts.small,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    toggleModal(true);
                                  }),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.delete_forever_outlined,
                                              size: 24,
                                              color: ColorPalette.danger,
                                            ),
                                          ),
                                          Text(
                                            "Delete account",
                                            style: Fonts.small.merge(
                                                const TextStyle(
                                                    color:
                                                        ColorPalette.danger)),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Button(
                      title: "Save changes",
                      variant: ((username != "" && username.length >= 4) ||
                              password != "" && password.length >= 8)
                          ? Variant.primary
                          : Variant.muted,
                      height: 64,
                      onClick: ((username != "" && username.length >= 4) ||
                              password != "" && password.length >= 8)
                          ? () async => updateUsernameAndPassword()
                          : () {},
                    )
                  ],
                ),
              ),
            ));
  }
}
