import 'dart:io';

import 'package:ballwizard/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class Lecturee extends StatelessWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  const Lecturee(
      {Key? key,
      required this.title,
      required this.body,
      required this.nextLecture,
      required this.prevLecture})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Lecture(
        title: title,
        body: body,
        nextLecture: nextLecture,
        prevLecture: prevLecture,
      );
}

class Lecture extends StatefulWidget {
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
  State<Lecture> createState() => LectureState();
}

class LectureState extends State<Lecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder(
          future: http.get(
            Uri.parse(
                'https://cdn.contentful.com/spaces/91dfqaqpv4yn/environments/master/entries/4KJsuTrWr7K74i3FBMMth6?'),
            headers: {
              HttpHeaders.authorizationHeader:
                  'LiOD0kCz-CecODuMpp0AjaRrXUfjX6SudR7XqHoCZw8',
            },
          ),
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                  data: "# test \n## wow \n### lamao ",
                  styleSheet: MarkdownStyleSheet(
                    h1: Fonts.heading,
                    h3: Fonts.medium,
                    h1Padding: const EdgeInsets.symmetric(vertical: 8),
                    h3Padding: const EdgeInsets.symmetric(vertical: 8),
                    p: Fonts.small,
                    pPadding: const EdgeInsets.symmetric(vertical: 4),
                  ));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
