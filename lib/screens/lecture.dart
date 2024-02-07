import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/firebase.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class Lecture extends StatelessWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  final String? image;
  final bool isUserLection;
  final bool mockIsCreator;
  Lecture({
    Key? key,
    required this.title,
    required this.body,
    required this.nextLecture,
    required this.prevLecture,
    required this.isUserLection,
    this.image,

    ///

    required this.mockIsCreator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _Lecture(
        title: title,
        body: body,
        nextLecture: nextLecture,
        prevLecture: prevLecture,
        image: image,
        isUserLection: isUserLection,
        mockIsCreator: mockIsCreator,
      );
}

class _Lecture extends StatefulWidget {
  final String title;
  final String body;
  final StatelessWidget nextLecture;
  final StatelessWidget prevLecture;
  final String? image;
  final bool isUserLection;

  final bool mockIsCreator;
  const _Lecture({
    Key? key,
    required this.title,
    required this.body,
    required this.nextLecture,
    required this.prevLecture,
    required this.isUserLection,
    this.image,

    ///

    required this.mockIsCreator,
  }) : super(key: key);

  @override
  State<_Lecture> createState() => LectureState();
}

class LectureState extends State<_Lecture> {
  late Color backgroundFABtn;
  void initState() {
    super.initState();

    if (checkIfLiked && widget.mockIsCreator) {
      backgroundFABtn = ColorPalette.danger;
    } else if (widget.mockIsCreator) {
      backgroundFABtn = ColorPalette.success;
    } else {
      backgroundFABtn = ColorPalette.muted;
    }

    // Additional initialization code if needed
  }

  bool checkIfLiked = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String displayContent() {
    //Content before image
    final content = widget.body.split(' ');
    List partOneList = [];
    for (int i = 0; i < content.length / 2; i++) {
      partOneList.add(content[i]);
    }
    //Content after the image (even divided
    List partTwoList = [];
    for (int i = (content.length / 2).round(); i < content.length; i++) {
      partTwoList.add(content[i]);
    }

    return !(widget.mockIsCreator)
        ? """ 
  ${widget.isUserLection ? '# ${widget.title}' : ''}
  ${widget.isUserLection && widget.image != '' ? partOneList.join(' ') : widget.body}

  ${widget.isUserLection && widget.image != '' ? '![${widget.title} lection image](${widget.image}#500x450)' : ''}

  ${widget.isUserLection && widget.image != '' ? partTwoList.join(' ') : ''}
  """
        : """
  ${'# ${widget.title}'}
  ${downloadURLFinal != '' ? partOneList.join(' ') : widget.body}

  ${downloadURLFinal != '' ? '![${widget.title} lection image]($downloadURLFinal#500x450)' : ''}

  ${downloadURLFinal != '' ? partTwoList.join(' ') : ''}
""";
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
      body: Markdown(
          data: displayContent(),
          styleSheet: MarkdownStyleSheet(
            h1: Fonts.heading,
            h3: Fonts.medium,
            h1Padding: const EdgeInsets.symmetric(vertical: 8),
            h3Padding: const EdgeInsets.symmetric(vertical: 8),
            p: Fonts.small,
            pPadding: const EdgeInsets.symmetric(vertical: 4),
          )),
      floatingActionButton: widget.mockIsCreator || widget.isUserLection
          ? FloatingActionButton(
              onPressed: widget.mockIsCreator
                  ? () {
                      addLectureWithDoc(
                        user.displayName!,
                        widget.title,
                        widget.body,
                        'intermidiate', //add tags
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                      // Make toast message that says that this is created succesful also push this on firebase
                    }
                  : () {
                      checkIfLiked = !checkIfLiked;
                      setState(() {
                        if (checkIfLiked && !widget.mockIsCreator) {
                          backgroundFABtn = ColorPalette.danger;
                        } else {
                          backgroundFABtn = ColorPalette.muted;
                        }
                      });

                      //Update docs so that liked content is set to true by this user view
                    },
              // backgroundColor: ColorPalette.dark,
              backgroundColor: backgroundFABtn,
              child: Icon(
                widget.mockIsCreator ? Icons.check : Icons.favorite,
                size: 25,
              ),
            )
          : null,
    );
  }
}


//Problems to fx 
//If username changes to display same user

