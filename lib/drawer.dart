import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/introduction_1.dart';
import 'package:ballwizard/screens/lecture.dart';
import 'package:ballwizard/screens/login.dart';
// import 'package:ballwizard/screens/logout.dart';
import 'package:ballwizard/screens/register.dart';
import 'package:ballwizard/screens/manage_user.dart';
import 'package:ballwizard/screens/user_info.dart';
import 'package:ballwizard/types.dart'
    show ColorPalette, DrawerElement, FundamentalVariant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///This up here is for signing out the user
///Add setState if you want to see changes, but I think that it is best that we redirect user to login screen, and not allowing them to come back
Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  print('Test signout'); //Check to see if it worl
}

Widget DrawerCustom(
    {required BuildContext context,
    FundamentalVariant variant = FundamentalVariant.light}) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).padding.top,
        child: ColoredBox(
          color: ColorPalette.primary,
        ),
      ),
      DrawerElement(
        title: FirebaseAuth.instance.currentUser?.displayName != null
            ? FirebaseAuth.instance.currentUser!.displayName!
            : "",
        // picture: Image.network(
        //   FirebaseAuth.instance.currentUser!.photoURL!,
        //   width: 34,
        //   height: 34,
        // ),// This is crashing the application if user is not logged in don't use it when building the application
        component: UserInformation(),
        context: context,
        color: ColorPalette.primary,
        textColor: ColorPalette.light,
      ),
      DrawerElement(
          title: "Manage user information",
          icon: const Icon(
            Icons.account_circle,
            size: 34,
            color: ColorPalette.dark,
          ),
          component: Start(),
          context: context),
      GestureDetector(
        // For some stupid reason flutter can't handle two events, I used too much time trying everything this is the best I got that is stil working
        onTap: () {
          _signOut();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },

        child: AbsorbPointer(
          child: DrawerElement(
              title: "Log out",
              icon: const Icon(Icons.logout),
              component: Login(),
              context: context),
        ),
      ),
      DrawerElement(
          title: "Login",
          icon: const Icon(Icons.logout),
          component: Login(),
          context: context),
      DrawerElement(
          title: "Register",
          icon: const Icon(Icons.people_alt),
          component: Register(),
          context: context),
      DrawerElement(
          title: "Home",
          icon: const Icon(Icons.house),
          component: const Home(),
          context: context),
      DrawerElement(
          title: "Introduction",
          icon: const Icon(Icons.arrow_right_alt_outlined),
          component: const Introduction(),
          context: context),
    ]),
  );
}

/*
SizedBox(
          height: 56,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName != null
                        ? FirebaseAuth.instance.currentUser!.displayName!
                        : "",
                    style: Fonts.small,
                  ),
                  FirebaseAuth.instance.currentUser?.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                            width: 34,
                            height: 34,
                          ),
                        )
                      : Icon(Icons.account_circle, size: 34)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ))),
 */

//  Lecture(
//                 title: "man",
//                 body: "# obamna\n### big\n- omaga",
//                 nextLecture: Start(),
//                 prevLecture: Start())
