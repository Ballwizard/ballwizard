import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8081);
      //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      //await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      print(e);
    }
  }
  runApp(MaterialApp(
      title: 'BallWizard',
      initialRoute: '/splash',
      routes: {
        '/home': (context) => const Home(),
        '/splash': (context) => AnimatedSplashScreen(
              splash: const Image(image: AssetImage("assets/logofb.png")),
              nextScreen: FirebaseAuth.instance.currentUser == null
                  ? Start()
                  : const Home(),
              duration: 2000,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: ColorPalette.light,
            ),
        '/intro': (context) => Start(),
      },
      home: FirebaseAuth.instance.currentUser == null ? Start() : const Home(),
      theme: ThemeData(
          primarySwatch: Colors.orange,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)))));
}
