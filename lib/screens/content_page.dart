import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/firebase.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/discover.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:ballwizard/blog_states.dart';

// class Nav extends StatelessWidget {
//   bool renderNavbar;

//   Nav({Key? key, this.renderNavbar = true}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ContentPage();
//   }
// }

class ContentPage extends StatefulWidget {
  // bool renderNavbar;
  final creatorView;
  final titleVal;
  final contentVal;
  ContentPage({super.key, this.titleVal, this.contentVal, this.creatorView});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  late Color backgroundFABtn;
  void initState() {
    super.initState();

    if (checkIfLiked && widget.creatorView) {
      backgroundFABtn = ColorPalette.danger;
    } else if (widget.creatorView) {
      backgroundFABtn = ColorPalette.success;
    } else {
      backgroundFABtn = ColorPalette.muted;
    }

    // Additional initialization code if needed
  }

  bool checkIfLiked = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: ColorPalette.dark),
      child: Scaffold(
        appBar: AppBarCustom(
            key: _key, context: context, type: AppBarVariant.arrowLogo),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Headings(
                    'Russian Criss Cross',
                    condition: true,
                    color: ColorPalette.dark,
                  ),
                  Text(
                    'Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorem  ',
                    textAlign: TextAlign.center,
                    style: Fonts.small,
                    //Break text
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        color: ColorPalette.muted,
                        borderRadius: BorderRadius.circular(10),
                        //change this to image
                      ),
                    ),
                  ),
                  Text(
                    'Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorrem Lorem',
                    textAlign: TextAlign.center,
                    style: Fonts.small,
                  ),
                  Image.network(downloadURLFinal)
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: widget.creatorView
              ? () {
                  addUserWithDoc(widget.titleVal, widget.contentVal, 'advanced',
                      user.displayName!);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                  // Make toast message that says that this is created succesful also push this on firebase
                }
              : () {
                  checkIfLiked = !checkIfLiked;
                  setState(() {
                    if (checkIfLiked && !widget.creatorView) {
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
            widget.creatorView ? Icons.check : Icons.favorite,
            size: 25,
          ),
        ),
      ),
    );
  }
}
