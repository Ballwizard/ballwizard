import 'dart:convert';

import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/types.dart'
    show
        AppBarVariant,
        ColorPalette,
        FundamentalVariant,
        Toast,
        ToastVariant,
        Variant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../card.dart';

class ManageActivity extends StatelessWidget {
  ManageActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return ManageActivityPage();
  }
}

class ManageActivityPage extends StatefulWidget {
  ManageActivityPage({super.key});

  @override
  State<ManageActivityPage> createState() => ManageActivityPageState();
}

class ManageActivityPageState extends State<ManageActivityPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool hasAssigned = false;
  List lectures = [];

  Future<dynamic> fetchHistory() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    DocumentSnapshot<Object?> history =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    return history.data() ?? [];
  }

  Future<List<Map<dynamic, dynamic>>> queryLectures() async {
    var lectures = await fetchHistory();
    Map<String, dynamic> str =
        jsonDecode(await rootBundle.loadString("assets/damn.json"))
            as Map<String, dynamic>;
    List<Map<dynamic, dynamic>> list = [];
    for (var i in lectures["history"]) {
      for (var lecture in str["lectures"]) {
        if (i == lecture["lecture_id"]) {
          list.add(lecture);
        }
      }
    }
    return list;
  }

  Future<void> deleteHistory(String lectureId) async {
    var history = await fetchHistory();
    (history["history"] as List<dynamic>).remove(lectureId);

    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    await ref.doc(FirebaseAuth.instance.currentUser!.uid).update(history);
  }

  @override
  Widget build(BuildContext context) {
    //if (FirebaseAuth.instance.currentUser == null) Navigator.pop(context);
    return FutureBuilder(
        future: queryLectures(),
        builder: (context, snapshot) {
          if (!hasAssigned && snapshot.data! != lectures) {
            Future.delayed(Duration.zero, () {
              setState(() {
                lectures =
                    (snapshot.data != null) ? snapshot.data! as List : [];
                hasAssigned = true;
              });
            });
          }

          return Scaffold(
              extendBodyBehindAppBar: true,
              key: _key,
              appBar: AppBarCustom(
                  type: AppBarVariant.arrow,
                  key: _key,
                  context: context,
                  isTransparent: true),
              endDrawer: DrawerCustom(context: context),
              body: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 64),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("History"),
                      Flexible(
                        child: ListView(
                            children: lectures
                                .asMap()
                                .entries
                                .map<Widget>((_lecture) {
                          var lecture = _lecture.value;

                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              child: Stack(
                                children: [
                                  CardElement(
                                    markdown: lecture["content"],
                                    title: lecture["title"],
                                    views: 5,
                                    dateOfCreation: DateTime.now(),
                                    thumbnail: lecture["thumbnail"],
                                    id: lecture["lecture_id"],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await deleteHistory(
                                            lecture["lecture_id"]);
                                        setState(() {
                                          lectures.removeAt(_lecture.key);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 4, top: 4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: SizedBox(
                                            height: 42,
                                            width: 42,
                                            child: ColoredBox(
                                              color: ColorPalette.light
                                                  .withOpacity(0.75),
                                              child: Icon(
                                                Icons.close,
                                                size: 26,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        }).toList()),
                      ),
                    ]),
              ));
        });
  }
}
