import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/modal.dart';
import 'package:ballwizard/types.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../state/toast.dart';
import '../toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  //Controllers
  TextEditingController username = TextEditingController();
  bool showGreen = false;

  // TextEditingController password = TextEditingController();
  // TextEditingController repeatPassword = TextEditingController();

  ///This is reusable for different Titles
  Widget titles(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Text(
        title,
        style: Fonts.medium,
      ),
    );
  }

  //Firebase authentication
  User? user = FirebaseAuth.instance.currentUser;

  void check() {
    print(user);
    print(username.text);
  }

  Future<void> updateUsername() async {
    try {
      if (user != null && username.text.length >= 3) {
        await user?.updateDisplayName(username.text);
        print('Succesfull');
      } else {
        print(false);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await user?.delete(); //this will delete user
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Icon(
                Icons.account_circle,
                size: 100,
                color: ColorPalette.dark,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${user?.displayName}',
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
                    controller: username,
                    placeholder: "Enter 5 or more charachters...",
                    label: "", //Change size of the label when we do code review
                    labelVariant: FundamentalVariant.dark,
                    variant: FundamentalVariant.light,
                    // onChanged: () {
                    //   username.text.length > 4 ? print(username) : showGreen;
                    // },
                    onChange: (a) {
                      print(a);
                      setState(() {
                        username.text.length > 4
                            ? showGreen = true
                            : showGreen = false;
                      });
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Hello world');
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                !showGreen
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 75,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorPalette.danger,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                // onPressed: deleteAccount,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Modal()));
                                },
                                child: const Text(
                                  'Delete account',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 75,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorPalette.success,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                // onPressed: updateUsername,
                                onPressed: check,
                                child: const Text(
                                  'Change username',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                        ),
                      )
              ],
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
