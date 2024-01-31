import 'dart:convert';
import 'dart:io';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../card.dart';

class DownloadedLectures extends StatelessWidget {
  const DownloadedLectures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Downloaded(key: key);
}

class Downloaded extends StatefulWidget {
  const Downloaded({
    Key? key,
  }) : super(key: key);

  @override
  State<Downloaded> createState() => DownloadedState();
}

class DownloadedState extends State<Downloaded> {
  bool hasAssigned = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List lectures = [];

  Future<List<Map<dynamic, dynamic>>> loadLectures() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Directory bw = await Directory("${dir.path}/bw").create();
    Map<String, dynamic> str =
        jsonDecode(await rootBundle.loadString("assets/damn.json"))
            as Map<String, dynamic>;
    List<Map<dynamic, dynamic>> list = [];
    for (var i in bw.listSync()) {
      for (var lecture in str["lectures"]) {
        if (i.path.split("/")!.last.contains(lecture["title"])) {
          lecture["thumbnail"] = File(i.path);
          list.add(lecture);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadLectures(),
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
              appBar: AppBarCustom(
                  key: _key, context: context, type: AppBarVariant.arrow),
              body: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      Text(
                        "Downloaded lectures",
                        style: Fonts.medium,
                      ),
                      Flexible(
                        child: lectures.length == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  "You have no downloaded lectures ;(",
                                  style: Fonts.smLight,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: ListView(
                                    children: lectures
                                        .asMap()
                                        .entries
                                        .map<Widget>((_lecture) {
                                  dynamic lecture = _lecture.value;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 16),
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ColorPalette.muted,
                                                  spreadRadius: 2,
                                                  blurRadius: 6,
                                                ),
                                              ]),
                                          child: CardElement(
                                            markdown: lecture["content"],
                                            title: lecture["title"],
                                            views: 5,
                                            dateOfCreation: DateTime.now(),
                                            thumbnail_file:
                                                lecture["thumbnail"],
                                            id: lecture["lecture_id"],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  lectures
                                                      .removeAt(_lecture.key);
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4, top: 4),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: SizedBox(
                                                    height: 42,
                                                    width: 42,
                                                    child: ColoredBox(
                                                      color: ColorPalette.light
                                                          .withOpacity(0.75),
                                                      child: Icon(
                                                        Icons
                                                            .delete_outline_outlined,
                                                        size: 32,
                                                        color:
                                                            ColorPalette.danger,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                }).toList()),
                              ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
/*

 */
