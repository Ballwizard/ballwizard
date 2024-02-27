// ignore_for_file: prefer_const_constructors

import 'dart:core';
import 'dart:io';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Lecture extends StatelessWidget {
  final String title;
  final String body;
  final String? thumbnail;
  final bool isDownloaded;
  final String id;
  final bool isUserLection;
  final bool mockIsCreator;
  final String? difficultyTag;
  final String? image;

  const Lecture(
      {super.key,
      required this.title,
      required this.body,
      required this.isUserLection,
      required this.mockIsCreator,
      this.id = "",
      this.difficultyTag,
      this.thumbnail,
      this.isDownloaded = false,
      this.image});

  @override
  Widget build(BuildContext context) => _Lecture(
        title: title,
        body: body,
        thumbnail: thumbnail,
        isDownloaded: isDownloaded,
        id: id,
        isUserLection: isUserLection,
        mockIsCreator: mockIsCreator,
        difficultyTag: difficultyTag,
      );
}

class _Lecture extends StatefulWidget {
  final String title;
  final String body;
  final String? thumbnail;
  final bool isDownloaded;
  final String id;
  final bool isUserLection;
  final String? difficultyTag;
  final bool mockIsCreator;
  //final String? image;
  const _Lecture(
      {required this.title,
      required this.body,
      required this.id,
      required this.isUserLection,
      required this.mockIsCreator,
      this.difficultyTag,
      this.thumbnail,
      this.isDownloaded = false});

  @override
  State<_Lecture> createState() => LectureState();
}

class LectureState extends State<_Lecture> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late Color backgroundFABtn;
  bool checkIfLiked = false;
  final downloadURLFinal = "";
  String id = "";
  String? comment;
  var value;

  @override
  void initState() {
    super.initState();
    checkHistory();

    if (widget.id != "") {
      setState(() {
        id = widget.id;
      });
    } else {
      getLectureIdByName(widget.title).then((value) => {
            setState(() {
              id = value ?? "";
            })
          });
    }

    if (checkIfLiked && widget.mockIsCreator) {
      backgroundFABtn = ColorPalette.danger;
    } else if (widget.mockIsCreator) {
      backgroundFABtn = ColorPalette.success;
    } else {
      backgroundFABtn = ColorPalette.muted;
    }

    // Additional initialization code if needed
  }

  dynamic checkHistory() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    var historyRef =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    var history = [];
    var deleted = [];

    if (!historyRef.exists) {
      await ref
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"history": [], "deleted": []});
    }

    try {
      history = historyRef.get("history");
      deleted = historyRef.get("deleted");
    } catch (e) {}

    if (deleted.contains(widget.id)) {
      deleted.remove(widget.id);
      history.add(widget.id);
      await ref
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"history": history, "deleted": deleted});
      return;
    }

    if (history.contains(widget.id)) {
      return;
    }

    history.add(widget.id);

    final lectureRef =
        FirebaseFirestore.instance.collection("lecture").doc(widget.id);
    final lecture = await lectureRef.get();

    await ref
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"history": history});

    if (!lecture.exists) {
      lectureRef.set({"count": 1});
    } else {
      lectureRef.update({"count": lecture["count"] + 1});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBarCustom(
          key: _key,
          context: context,
          type: AppBarVariant.arrowLogo,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Expanded(
                  child: Markdown(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    data: widget.body,
                    styleSheet: MarkdownStyleSheet(
                      h1: Fonts.heading,
                      h3: Fonts.medium,
                      h1Padding: const EdgeInsets.symmetric(vertical: 8),
                      h3Padding: const EdgeInsets.symmetric(vertical: 8),
                      p: Fonts.small,
                      pPadding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                ),
                widget.isDownloaded
                    ? Container()
                    : SizedBox(
                        height: 64,
                      )
              ],
            ),
            widget.isDownloaded
                ? Container()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: FloatingActionButton(
                        focusColor: ColorPalette.secondary,
                        foregroundColor: ColorPalette.light,
                        backgroundColor: ColorPalette.secondary,
                        onPressed: () async {
                          var _value = await fetchComments(id);

                          setState(() => value = _value);

                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setModalState) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 16),
                                        child: Text(
                                          "Comments (${value.length})",
                                          style: Fonts.medium,
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: value.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                child: Card(
                                                  shadowColor:
                                                      ColorPalette.dark,
                                                  borderOnForeground: true,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          value[index]["user"],
                                                          style: Fonts.small,
                                                        ),
                                                        Text(
                                                          value[index]["text"],
                                                          style:
                                                              Fonts.smallLight,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                        horizontal: 16),
                                                child: TextField(
                                                    onChanged: (val) {
                                                      setState(() {
                                                        comment = val;
                                                      });
                                                    },
                                                    maxLength: 256,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Write your comment here",
                                                      hintStyle: Fonts.small,
                                                      focusColor: ColorPalette
                                                          .secondary,
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 8),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (comment == null ||
                                                      comment == "") return;

                                                  await addComment(
                                                      id, comment!);

                                                  fetchComments(id)
                                                      .then((value_) {
                                                    setModalState(() {
                                                      value = value_;
                                                    });
                                                  });
                                                },
                                                child: Icon(Icons.send,
                                                    size: 24,
                                                    color: ColorPalette.dark),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                              });
                        },
                        child: const Icon(Icons.comment),
                      ),
                    ),
                  ),
            widget.isDownloaded
                ? Container()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: FloatingActionButton(
                        focusColor: ColorPalette.primary,
                        foregroundColor: ColorPalette.light,
                        backgroundColor: ColorPalette.primary,
                        onPressed: () async {
                          http.Response response = await http.get(Uri.parse(widget
                                          .thumbnail ==
                                      null ||
                                  widget.thumbnail == ""
                              ? "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-white-solid-color-background.jpg"
                              : widget.thumbnail!));
                          Directory dir =
                              await getApplicationDocumentsDirectory();
                          Directory bw =
                              await Directory("${dir.path}/bw").create();
                          File file =
                              File(path.join(bw.path, "${widget.title}.png"));
                          await file.writeAsBytes(response.bodyBytes);
                        },
                        child: const Icon(Icons.download),
                      ),
                    ),
                  ),
          ],
        ));
  }
}
