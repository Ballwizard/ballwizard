import 'dart:io';

import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/lecture.dart';
import 'package:ballwizard/types.dart' show FundamentalVariant, ColorPalette;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Calculates the best way to display a certain upload date
///
/// Example: if the video was uploaded 50 hours ago it will be simplified / rounded to 2 days ago
String calculateBestDateFormat(DateTime targetDate) {
  // dateDifference is in milliseconds, so we have to convert it to a nicer format
  int dateDifference = DateTime.now().difference(targetDate).inMilliseconds;

  // time spans in milliseconds
  const toYears = 1000 * 3600 * 24 * 365;
  const toMonths = toYears / 12;
  const toWeeks = toMonths / 4;
  const toDays = toWeeks / 7;
  const toHours = toDays / 24;
  const toMinutes = toHours / 60;

  // time spans and their names
  List<Map<String, dynamic>> timeSpans = [
    {"duration": toYears, "name": "year"},
    {"duration": toMonths, "name": "month"},
    {"duration": toWeeks, "name": "week"},
    {"duration": toDays, "name": "day"},
    {"duration": toHours, "name": "hour"},
    {"duration": toMinutes, "name": "minute"},
  ];

  // this loop iterates for every time span and finds the optimal time span format to display to the user
  for (int i = 0; i < timeSpans.length; i++) {
    // select a time span from timeSpans
    Map<String, dynamic> timeSpan = timeSpans[i];

    if (dateDifference / timeSpan["duration"] > 0.67) {
      // calculate rounded duration in every time span in timeSpans
      int timeValue = (dateDifference / timeSpan["duration"]).round();

      // return in format = value time_span_name/s ago (for example 12 minutes ago)
      return "$timeValue ${timeValue == 1 ? timeSpan["name"] : timeSpan["name"] + "s"} ago";
    }
  }
  // if video was uploaded less than 40.2 seconds ago (none of the above conditions were met), it will display as a few seconds ago
  return "few seconds ago";
}

class CardElement extends StatelessWidget {
  final String title;
  final int? views;
  final DateTime dateOfCreation;
  final String markdown;
  final FundamentalVariant variant;
  final String thumbnail;
  final bool large;
  final File? thumbnailFile;
  final String id;
  final bool? isLiked;
  final String? author;

  const CardElement(
      {super.key,
      required this.title,
      required this.dateOfCreation,
      required this.id,
      this.views,
      this.markdown = "",
      this.variant = FundamentalVariant.light,
      this.thumbnail = "",
      this.large = false,
      this.thumbnailFile,
      this.isLiked,
      this.author});

  @override
  Widget build(BuildContext context) => CardElementPage(
      title: title,
      dateOfCreation: dateOfCreation,
      id: id,
      views: views,
      markdown: markdown,
      variant: variant,
      thumbnail: thumbnail,
      large: large,
      thumbnail_file: thumbnailFile,
      isLiked: isLiked,
      author: author);
}

class CardElementPage extends StatefulWidget {
  final String title;
  final int? views;
  final DateTime dateOfCreation;
  final String markdown;
  final FundamentalVariant variant;
  final String thumbnail;
  final bool large;
  final File? thumbnail_file;
  final String id;
  final bool? isLiked;
  final String? author;

  const CardElementPage(
      {super.key,
      required this.title,
      required this.dateOfCreation,
      required this.id,
      this.views,
      this.markdown = "",
      this.variant = FundamentalVariant.light,
      this.thumbnail = "",
      this.large = false,
      this.thumbnail_file,
      this.isLiked,
      this.author});

  @override
  State<CardElementPage> createState() => CardElementPageState();
}

class CardElementPageState extends State<CardElementPage> {
  bool isLiked = false;

  Future<bool> checkIfLiked() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    var historyRef =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    var liked = [];

    if (!historyRef.exists) {
      await ref
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"history": [], "deleted": [], "liked": []});
      return false;
    }

    try {
      liked = historyRef.get("liked");
    } catch (e) {
      return false;
    }

    if (liked.contains(widget.id)) {
      return true;
    }

    return false;
  }

  Future<void> likePost() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    var historyRef =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    var liked = [];

    if (!historyRef.exists) {
      await ref.doc(FirebaseAuth.instance.currentUser!.uid).set({
        "history": [],
        "deleted": [],
        "liked": [widget.id]
      });
      return;
    }

    try {
      liked = historyRef.get("liked");
    } catch (e) {}

    if (liked.contains(widget.id)) {
      liked.remove(widget.id);
    } else {
      liked.add(widget.id);
    }

    await ref
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"liked": liked});
  }

  @override
  void initState() {
    if (widget.isLiked == null) {
      checkIfLiked().then((value) {
        setState(() {
          isLiked = value;
        });
      });
    } else {
      isLiked = widget.isLiked!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Lecture(
              title: widget.title,
              body: widget.markdown,
              thumbnail: widget.thumbnail,
              id: widget.id,
              isUserLection: false,
              mockIsCreator: false,
              isDownloaded: widget.thumbnail_file != null,
            ),
          ),
        );
      },
      child: FractionallySizedBox(
        widthFactor: 1,
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.66,
          child: Stack(
            children: [
              Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: SizedBox(
                        height:
                            MediaQuery.of(context).size.width * 0.66 * 2 / 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: ColoredBox(
                            color: ColorPalette.light,
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: widget.thumbnail == ""
                                    ? widget.thumbnail_file == null
                                        ? Container()
                                        : Image(
                                            image: FileImage(
                                                widget.thumbnail_file!,
                                                scale: 4),
                                          )
                                    : Image.network(widget.thumbnail)),
                          ),
                        )),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.66 * 1 / 3,
                      child: Stack(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.zero,
                                      bottom: Radius.circular(15)),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: Fonts.medium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        widget.views != null
                                            ? Text("${widget.views} views",
                                                style: Fonts.smallLight)
                                            : Container(),
                                        widget.views != null
                                            ? Text(" - ",
                                                style: Fonts.smallLight)
                                            : Container(),
                                        Text(
                                            calculateBestDateFormat(
                                                widget.dateOfCreation),
                                            style: Fonts.smallLight),
                                        widget.author != null
                                            ? Text(" - ",
                                                style: Fonts.smallLight)
                                            : Container(),
                                        widget.author != null
                                            ? Text(widget.author!,
                                                style: Fonts.smallLight)
                                            : Container(),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          widget.isLiked == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        likePost();
                                        setState(() {
                                          isLiked = !isLiked;
                                        });
                                      },
                                      child: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        size: 32,
                                        color: ColorPalette.danger,
                                        grade: 200,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
