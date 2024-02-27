import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart'
    show ColorPalette, FundamentalVariant, LectureObject;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../card.dart';
import 'create_user_lecture.dart';

class MainList extends StatefulWidget {
  const MainList({
    Key? key,
  }) : super(key: key);

  @override
  State<MainList> createState() => MainListState();
}

class MainListState extends State<MainList> {
  bool hasScrolled = false;
  List<LectureObject> lectures = [];
  List<dynamic> likedLectures = [];

  Future<List<LectureObject>> fetchLectures() async {
    final tags = await getUserTags();
    final videos = await recommendVideos(tags);
    List<LectureObject> recommendedVideos = [];

    for (String id in videos) {
      LectureObject lecture = await LectureObject.fromId(id);
      recommendedVideos.add(lecture);
    }

    if (recommendedVideos.isEmpty) {
      recommendedVideos = await getAllLectures();
    }

    return recommendedVideos;
  }

  Future<List<dynamic>> fetchLikedLectures() async {
    final CollectionReference ref =
        FirebaseFirestore.instance.collection("history");

    var historyRef =
        await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

    var liked = [];

    if (!historyRef.exists) {
      return [];
    }

    try {
      liked = historyRef.get("liked");
    } catch (e) {
      return [];
    }

    return liked;
  }

  @override
  void initState() {
    fetchLectures().then((value) {
      setState(() {
        lectures = value;
      });
    });

    fetchLikedLectures().then((value) {
      setState(() {
        likedLectures = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateBlog()));
          },
          // backgroundColor: ColorPalette.dark,
          backgroundColor: ColorPalette.successMuted,
          child: const Icon(
            Icons.add,
            size: 32,
            color: ColorPalette.light,
          ),
        ),
        body: GradientBackground(
            variant: FundamentalVariant.light,
            child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: lectures.isEmpty
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(
                              color: ColorPalette.light,
                            ),
                            width: 64,
                            height: 64,
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: hasScrolled ? 0 : 12),
                        child: NotificationListener<ScrollUpdateNotification>(
                          onNotification: (_) {
                            if (_.metrics.pixels > 1) {
                              setState(() {
                                hasScrolled = true;
                              });
                            }
                            if (hasScrolled && _.metrics.pixels <= 1) {
                              setState(() {
                                hasScrolled = false;
                              });
                            }
                            return true;
                          },
                          child: ListView(
                              children: lectures
                                      .map<Widget>(
                                        (lecture) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 16),
                                          child: CardElement(
                                            id: lecture.id,
                                            title: lecture.title!,
                                            markdown: lecture.content!,
                                            dateOfCreation:
                                                lecture.dateOfCreation!,
                                            thumbnail: lecture.thumbnail!,
                                            views: lecture.views == null
                                                ? 0
                                                : lecture.views!,
                                            isLiked: likedLectures
                                                .contains(lecture.id),
                                            author: lecture.author,
                                          ),
                                        ),
                                      )
                                      .toList() +
                                  [
                                    const SizedBox(
                                      height: 80,
                                    )
                                  ]),
                        ),
                      ))));
  }
}

/*
:
 */
