import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/firebase.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/modal.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

import '../state/toast.dart';

class ManageUser extends StatelessWidget {
  bool renderNavbar;

  ManageUser({super.key, this.renderNavbar = true});

  @override
  Widget build(BuildContext context) {
    return ManageUserPage();
  }
}

class ManageUserPage extends StatefulWidget {
  bool renderNavbar;

  ManageUserPage({super.key, this.renderNavbar = true});

  @override
  State<ManageUserPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ManageUserPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final ToastQueue queue = ToastQueue();

  //Controllers

  String username = '';
  bool showGreen = false;
  bool showModal = false;

  ///This is reusable for different Titles
  Widget titles(String title) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Text(
          title,
          style: Fonts.medium,
          //   .copyWith(
          //       decoration: TextDecoration.underline,
          //       decorationThickness: 4,
          //       decorationColor: ColorPalette.dark.withOpacity(0.5)),
          // ),
        ));
  }

  //Firebase authentication
  // User? user = FirebaseAuth.instance.currentUser;
  void check() {}

  // // Future<void> deleteAccount() async {
  //   try {
  //     await user?.delete(); //this will delete user
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget buttons(String text, func, bool isRed) {
    return (Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: SizedBox(
          width: double.infinity,
          height: 75,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isRed ? ColorPalette.danger : ColorPalette.success,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              // onPressed: deleteAccount,
              onPressed: func,
              child: Text(
                text,
                style: Fonts.medium.copyWith(color: ColorPalette.light),
              )),
        ),
      ),
    ));
  }

  void toggleModal(bool value) {
    setState(() {
      showModal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showModal
        ? Modal(
            showModal: showModal,
            toggleModal: toggleModal,
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            key: _key,
            appBar: widget.renderNavbar
                ? AppBarCustom(
                    type: AppBarVariant.arrowLogo, key: _key, context: context)
                : null,
            body: Container(
              margin: const EdgeInsets.only(top: 120),
              height: double.infinity,
              width: double.infinity,
              child: Column(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await chooseProfilePic();
                        setState(() {
                          displayPfpImg;
                        });
                      },
                      child: user.photoURL != null
                          ? Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2000),
                                  border: Border.all(
                                    color: Colors.black, // Set the border color
                                    width: 2, // Set the border width
                                  )),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2000),
                                child: Image.network(
                                  displayPfpImg,
                                  fit: BoxFit.cover,
                                ),
                              ), //This checks just one more time because compiler throws an error
                            )
                          : const Icon(
                              Icons.account_circle,
                              size: 100,
                              color: ColorPalette.dark,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${displayUsername}',
                        style: Fonts.heading,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 50,
                        right: 50,
                      ),
                      child: Divider(
                        color: ColorPalette.dark,
                        thickness: 1.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titles('Change username'),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 195,
                      ),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                        //Looks better but try to remove it
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Form1.Input(
                          placeholder: "Enter 3 or more charachters...",
                          label:
                              "", //Change size of the label when we do code review
                          labelVariant: FundamentalVariant.dark,
                          variant: FundamentalVariant.light,
                          onChange: (val) {
                            setState(() {
                              username = val;
                              username.length > 2
                                  ? showGreen = true
                                  : showGreen = false;
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //History using firebase should be implemented here
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Manage activity',
                                style: Fonts.medium,
                              ),
                              const Icon(
                                Icons.open_in_new_rounded,
                                size: 28,
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        !showGreen
                            ? buttons('Delete account', () {
                                // check();
                                setState(() {
                                  toggleModal(true);
                                });
                              }, true)
                            : buttons('Change username', () async {
                                await updateUsername(username);
                                setState(() {
                                  displayUsername;
                                  showGreen = !showGreen;
                                });
                              }, false)
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
  }
}

// endDrawer: DrawerCustom(context: context),
//     bottomSheet: ListenableBuilder(
//       listenable: queue,
//       builder: (BuildContext context, Widget? child) {
//         if (queue.current != null) {
//           return AnimatedOpacity(
//               opacity: 1,
//               duration: const Duration(milliseconds: 200),
//               child: ToastComponent(toast: queue.current!));
//         }
//         return SizedBox();
//       },
//     ),
//     body: GradientBackground(
//       variant: FundamentalVariant.light,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Form1.Input(
//                   placeholder: "test",
//                   label: "Field name",
//                   variant: FundamentalVariant.light)),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Button(
//                 onClick: () {
//                   print("hello");
//                   queue.add(
//                       Toast(variant: ToastVariant.success, value: "omaga"));
//                 },
//                 title: "test",
//               )),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Button(
//                 onClick: () {
//                   print("hello");
//                   queue.add(
//                       Toast(variant: ToastVariant.error, value: "omaga"));
//                 },
//                 title: "test",
//               )),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Button(
//                 onClick: () {
//                   print("hello");
//                   queue.add(
//                       Toast(variant: ToastVariant.warning, value: "omaga"));
//                 },
//                 title: "test",
//               )),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Button(
//                 onClick: () {
//                   print("hello");
//                 },
//                 title: "test",
//               )),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Button(
//                 onClick: () {
//                   print("hello");
//                   queue.removeAll();
//                 },
//                 title: "test",
//               )),
//           Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               child: Form1.Input(
//                   placeholder: "test",
//                   label: "Field name",
//                   variant: FundamentalVariant.dark)),
//           Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               child: Form1.Input(
//                   placeholder: "test",
//                   label: "Field name",
//                   variant: FundamentalVariant.dark)),
//         ],
//       ),
//     ),
//   );
// }

//////////////////////////

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

//  TextField(
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black, width: 1.5),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.black54, width: 1.5),
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                       hintText: 'Enter your password...'),
//                 ),

// ////  Widget subsections(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 28, top: 10),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 17,
//         ),
//       ),
//     );
//   }
