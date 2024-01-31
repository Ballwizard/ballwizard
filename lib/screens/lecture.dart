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
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  final String? thumbnail;
  final bool isDownloaded;
  final String id;
  const Lecture(
      {Key? key,
      required this.title,
      required this.body,
      required this.nextLecture,
      required this.prevLecture,
      required this.id,
      this.thumbnail,
      this.isDownloaded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _Lecture(
      title: title,
      body: body,
      nextLecture: nextLecture,
      prevLecture: prevLecture,
      thumbnail: thumbnail,
      isDownloaded: isDownloaded,
      id: id);
}

class _Lecture extends StatefulWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  final String? thumbnail;
  final bool isDownloaded;
  final String id;
  const _Lecture(
      {Key? key,
      required this.title,
      required this.body,
      required this.nextLecture,
      required this.prevLecture,
      required this.id,
      this.thumbnail,
      this.isDownloaded = false})
      : super(key: key);

  @override
  State<_Lecture> createState() => LectureState();
}

class LectureState extends State<_Lecture> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Future<dynamic> fetchHistory() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    DocumentSnapshot<Object?> history =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    return history.data() ?? [];
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
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Markdown(
                  data: widget.body,
                  styleSheet: MarkdownStyleSheet(
                    h1: Fonts.heading,
                    h3: Fonts.medium,
                    h1Padding: const EdgeInsets.symmetric(vertical: 8),
                    h3Padding: const EdgeInsets.symmetric(vertical: 8),
                    p: Fonts.small,
                    pPadding: const EdgeInsets.symmetric(vertical: 4),
                  )),
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
                        onPressed: widget.thumbnail == null
                            ? () {}
                            : () async {
                                http.Response response = await http
                                    .get(Uri.parse(widget.thumbnail!));
                                Directory dir =
                                    await getApplicationDocumentsDirectory();
                                Directory bw =
                                    await Directory("${dir.path}/bw").create();
                                File file = File(
                                    path.join(bw.path, "${widget.title}.png"));
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
