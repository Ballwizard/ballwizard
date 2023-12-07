import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Lecture extends StatelessWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  const Lecture(
      {Key? key,
      required this.title,
      required this.body,
      required this.nextLecture,
      required this.prevLecture})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _Lecture(
        title: title,
        body: body,
        nextLecture: nextLecture,
        prevLecture: prevLecture,
      );
}

class _Lecture extends StatefulWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  const _Lecture(
      {Key? key,
      required this.title,
      required this.body,
      required this.nextLecture,
      required this.prevLecture})
      : super(key: key);

  @override
  State<_Lecture> createState() => LectureState();
}

class LectureState extends State<_Lecture> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBarCustom(
          key: _key,
          context: context,
          type: AppBarVariant.arrowLogo,
        ),
        body: Markdown(
            data: widget.body,
            styleSheet: MarkdownStyleSheet(
              h1: Fonts.heading,
              h3: Fonts.medium,
              h1Padding: const EdgeInsets.symmetric(vertical: 8),
              h3Padding: const EdgeInsets.symmetric(vertical: 8),
              p: Fonts.small,
              pPadding: const EdgeInsets.symmetric(vertical: 4),
            )));
  }
}
