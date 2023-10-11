import 'package:ballwizard/cms_objects/lecture.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

import '../card.dart';

class MainList extends StatefulWidget {
  const MainList({
    Key? key,
  }) : super(key: key);

  @override
  State<MainList> createState() => MainListState();
}

class MainListState extends State<MainList> {
  bool hasScrolled = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LectureContent>>(
      future: Repository().getProducts(),
      builder: (context, snapshot) {
        dynamic lectures = (snapshot.data != null) ? snapshot.data! : [];

        return Scaffold(
            appBar: null,
            body: GradientBackground(
              variant: FundamentalVariant.light,
              child: FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: lectures.length != 0
                      ? Padding(
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
                                            markdown:
                                                lectures[0].fields!.content,
                                            thumbnail: "https://" +
                                                lecture
                                                    .fields!
                                                    .thumbnail["fields"]["file"]
                                                        ["url"]
                                                    .substring(2),
                                            title: lecture.fields!.title,
                                            views: lecture.fields!.views,
                                            dateOfCreation:
                                                lecture.fields!.dateOfCreation),
                                      ),
                                    )
                                    .toList()),
                          ),
                        )
                      : Row(
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
                        )),
            ));
      },
    );
  }
}
/*
Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                        child: CardElement(
                            title: "breathe in the air",
                            views: 93213,
                            dateOfCreation: DateTime.timestamp()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        child: CardElement(
                            title: "breathe in the air",
                            views: 93213,
                            dateOfCreation: DateTime.timestamp()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        child: CardElement(
                            title: "breathe in the air",
                            views: 93213,
                            dateOfCreation: DateTime.timestamp()),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                        child: CardElement(
                            title: "breathe in the air",
                            views: 93213,
                            dateOfCreation: DateTime.timestamp()),
                      ),
 */
