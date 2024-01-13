import 'package:ballwizard/button.dart' show Button;
import 'package:ballwizard/chip.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/splash.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart'
    show ColorPicker, FundamentalVariant, Variant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8081);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      print(e);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BallWizard',
        initialRoute: '/splash',
        routes: {
          '/home': (context) => Home(),
          '/splash': (context) => SplashScreen(),
          '/intro': (context) => Start(),
        },
        home: const MyHomePage(title: 'Flutter Demo Home Pag123e'),
        theme: ThemeData(
            primarySwatch: Colors.orange,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerCustom(context: context),
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GradientBackground(
        variant: FundamentalVariant.light,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          if (currIndex == 0)
                            currIndex = -1;
                          else
                            currIndex = 0;
                        });
                      },
                      child: ChipElement(
                          text: "Begginer",
                          variant: Variant.success,
                          isSelected: currIndex == 0),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () async {
                        // Create a storage reference from our app
                        final storageRef = FirebaseStorage.instance.ref();
                        final mountainsRef = storageRef.child("mountains.jpg");
                        try {
                          await mountainsRef.putString(
                              'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==',
                              format: PutStringFormat.dataUrl);
                        } catch (e) {
                          print(e);
                        }

                        print("prolly finished");
                      },
                      child: ChipElement(
                          text: "Test",
                          variant: Variant.dark,
                          isSelected: currIndex == 1),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    onChange: (String text) {
                      print(text);
                    },
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.light)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.light)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                  },
                  title: "Start",
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Button(
                  onClick: () {
                    print("hello");
                    Navigator.pop(context);
                  },
                  title: "test",
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Form1.Input(
                    placeholder: "test",
                    label: "Field name",
                    variant: FundamentalVariant.dark))
          ],
        ),
      ),
    );
  }
}
