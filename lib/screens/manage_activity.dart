import 'dart:convert';

import 'package:ballwizard/appbar.dart' show AppBarCustom;
import 'package:ballwizard/chip.dart';
import 'package:ballwizard/drawer.dart';
import 'package:ballwizard/types.dart'
    show AppBarVariant, ColorPalette, Variant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../card.dart';
import '../globals.dart';

class ManageActivity extends StatelessWidget {
  const ManageActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return const ManageActivityPage();
  }
}

class ManageActivityPage extends StatefulWidget {
  const ManageActivityPage({super.key});

  @override
  State<ManageActivityPage> createState() => ManageActivityPageState();
}

class ManageActivityPageState extends State<ManageActivityPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool hasAssigned = false;
  List lectures = [];
  List liked = [];
  bool likedSwitch = false;

  @override
  void initState() {
    queryLectures().then((value) => {
          setState(() {
            lectures = value[0];
            liked = value[1];
          })
        });

    super.initState();
  }

  Future<dynamic> fetchHistory() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    DocumentSnapshot<Object?> history =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    return history.data() ?? {"history": [], "liked": [], "deleted": []};
  }

  Future<List<List<Map<dynamic, dynamic>>>> queryLectures() async {
    var lectures = await fetchHistory();
    lectures = lectures;
    Map<String, dynamic> str =
        jsonDecode(await getJsonFile()) as Map<String, dynamic>;
    List<Map<dynamic, dynamic>> history = [];
    List<Map<dynamic, dynamic>> liked = [];

    for (var i in lectures["history"]) {
      for (var lecture in str["lectures"]) {
        if (i == lecture["lecture_id"]) {
          history.add(lecture);
        }
      }
    }
    try {
      for (var i in lectures["liked"]) {
        for (var lecture in str["lectures"]) {
          if (i == lecture["lecture_id"]) {
            liked.add(lecture);
          }
        }
      }
    } catch (e) {}
    return [history, liked];
  }

  Future<void> deleteHistory(String lectureId) async {
    var history = await fetchHistory();
    history["history"].remove(lectureId);
    if (history.containsKey("deleted")) {
      history["deleted"].add(lectureId);
    } else {
      history["deleted"] = [lectureId];
    }

    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    await ref.doc(FirebaseAuth.instance.currentUser!.uid).update(history);
  }

  @override
  Widget build(BuildContext context) {
    //if (FirebaseAuth.instance.currentUser == null) Navigator.pop(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _key,
        appBar: AppBarCustom(
            type: AppBarVariant.arrow, key: _key, context: context),
        endDrawer: DrawerCustom(context: context),
        body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 64),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                likedSwitch ? "Liked lectures" : "History",
                style: Fonts.medium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        likedSwitch = false;
                      });
                    },
                    child: ChipElement(
                        text: "History",
                        variant: likedSwitch ? Variant.muted : Variant.primary,
                        width: MediaQuery.of(context).size.width / 3 + 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        likedSwitch = true;
                      });
                    },
                    child: ChipElement(
                        text: "Liked lectures",
                        variant: likedSwitch ? Variant.primary : Variant.muted,
                        width: MediaQuery.of(context).size.width / 3 + 16),
                  ),
                ],
              ),
            ),
            Flexible(
              child: lectures.isEmpty && !likedSwitch ||
                      liked.isEmpty && likedSwitch
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        likedSwitch
                            ? "You haven't liked any lectures."
                            : "You haven't read any lectures.",
                        style: Fonts.smLight,
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: (likedSwitch ? liked : lectures)
                          .asMap()
                          .entries
                          .map<Widget>((lecture_) {
                        var lecture = lecture_.value;
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: ColorPalette.muted,
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                        )
                                      ]),
                                  child: CardElement(
                                    markdown: lecture["content"],
                                    title: lecture["title"],
                                    dateOfCreation: DateTime.parse(
                                        lecture["date_of_creation"]),
                                    thumbnail: lecture["thumbnail"],
                                    id: lecture["lecture_id"],
                                    isLiked: likedSwitch ? true : null,
                                    author: lecture["author"],
                                  ),
                                ),
                                likedSwitch
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            await deleteHistory(
                                                lecture["lecture_id"]);
                                            setState(() {
                                              lectures.removeAt(lecture_.key);
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
                                                  child: const Icon(
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
  }
}
