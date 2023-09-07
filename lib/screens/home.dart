import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/main2.dart';
import 'package:ballwizard/screens/login.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final pages = <StatelessWidget>[
    Start(),
    Login(renderNavbar: false),
    MyApp2()
  ];

  int index = 0;

  void changeIndex(int _index) {
    setState(() {
      index = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          key: _key, context: context, type: AppBarVariant.logoPicture),
      body: Center(
        child: pages.elementAt(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.amber[800],
        onTap: changeIndex,
      ),
    );
  }
}
