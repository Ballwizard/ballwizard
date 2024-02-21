import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/main_list.dart';
import 'package:ballwizard/screens/search.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

import 'discover.dart';

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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final pages = [const MainList(), const Search(), const Discover()];

  int index = 0;

  void changeIndex(int index_) {
    setState(() {
      index = index_;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _key,
      appBar: index == 1
          ? null
          : AppBarCustom(
              key: _key, context: context, type: AppBarVariant.logoPicture),
      body: Center(
        child: pages.elementAt(index),
      ),
      endDrawer: DrawerCustom(context: context),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: Fonts.small,
        selectedLabelStyle: Fonts.small,
        iconSize: 28,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map_sharp),
            label: 'Discover',
          ),
        ],
        currentIndex: index,
        selectedItemColor: ColorPalette.primary,
        onTap: changeIndex,
      ),
    );
  }
}
