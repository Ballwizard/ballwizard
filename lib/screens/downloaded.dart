// ignore_for_file: prefer_is_empty

import 'dart:convert';
import 'dart:io';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../card.dart';

class DownloadedLectures extends StatelessWidget {
  const DownloadedLectures({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Downloaded(key: key);
}

class Downloaded extends StatefulWidget {
  const Downloaded({
    super.key,
  });

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
        jsonDecode(await getJsonFile()) as Map<String, dynamic>;
    List<Map<dynamic, dynamic>> list = [];

    for (var i in bw.listSync()) {
      for (var lecture in str["lectures"]) {
        if (i.path.split("/").last.contains(lecture["title"])) {
          lecture["thumbnail"] = File(i.path);
          list.add(lecture);
        }
      }
    }
    return list;
  }

  @override
  void initState() {
    loadLectures().then((value) {
      setState(() {
        lectures = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            key: _key, context: context, type: AppBarVariant.arrow),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
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
                                  .map<Widget>((lecture_) {
                            dynamic lecture = lecture_.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: ColorPalette.muted,
                                            spreadRadius: -1,
                                            blurRadius: 4,
                                          )
                                        ]),
                                    child: CardElement(
                                      markdown: lecture["content"],
                                      title: lecture["title"],
                                      dateOfCreation: DateTime.parse(
                                          lecture["date_of_creation"]),
                                      thumbnailFile: lecture["thumbnail"],
                                      id: lecture["lecture_id"],
                                      author: lecture["author"],
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            lectures.removeAt(lecture.key);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 4, top: 4),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            child: SizedBox(
                                              height: 42,
                                              width: 42,
                                              child: ColoredBox(
                                                color: ColorPalette.light
                                                    .withOpacity(0.75),
                                                child: const Icon(
                                                  Icons.delete_outline_outlined,
                                                  size: 32,
                                                  color: ColorPalette.danger,
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
  }
}
/*

 */
