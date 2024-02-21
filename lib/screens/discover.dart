import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/create_user_lecture.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

import '../card.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  Map<String, List<LectureObject>> tagMap = {};
  List liked = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Stopwatch stopwatch = Stopwatch()..start();
    final tags = await getUserTags();

    final map = await getLecturesByTags(tags);
    final likedLectures = await fetchLikedLectures();

    stopwatch.stop();
    setState(() {
      liked = likedLectures;
      tagMap = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBackground(
            variant: FundamentalVariant.light,
            child: GestureDetector(
              child: DefaultTextStyle(
                style: const TextStyle(color: ColorPalette.dark),
                child: ListView(
                  children: tagMap.keys.map((e) {
                        if (tagMap[e]!.isEmpty)
                          return const SizedBox(
                            height: 0,
                          );
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              child: Text(
                                TAG_MAP[e] ?? "",
                                style: Fonts.large.merge(
                                    const TextStyle(color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                  controller: ScrollController(
                                      initialScrollOffset: -16,
                                      keepScrollOffset: true),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                        const SizedBox(
                                          width: 16,
                                        )
                                      ] +
                                      tagMap[e]!.map(
                                        (e) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                32,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: CardElement(
                                                title: e.title ?? "",
                                                dateOfCreation:
                                                    e.dateOfCreation ??
                                                        DateTime.now(),
                                                id: e.id,
                                                markdown: e.content ?? "",
                                                views: e.views,
                                                thumbnail: e.thumbnail ?? " ",
                                                author: e.author,
                                                isLiked: liked.contains(e.id),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList()),
                            ),
                          ],
                        );
                      }).toList() +
                      [
                        const SizedBox(
                          height: 80,
                        )
                      ],
                ),
              ),
            )),
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
        ));
  }
}
