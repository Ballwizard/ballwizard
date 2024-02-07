import 'dart:io';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/blog_states.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/lecture.dart';
import 'package:ballwizard/firebase.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/content_page.dart';
import 'package:ballwizard/screens/manage_user.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:image_picker/image_picker.dart';

class Nav extends StatelessWidget {
  bool renderNavbar;

  Nav({Key? key, this.renderNavbar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreateBlog();
  }
}

class CreateBlog extends StatefulWidget {
  bool renderNavbar;
  CreateBlog({super.key, this.renderNavbar = true});
  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // File? globalImage;
  // choosePic() async {
  //   try {
  //     final pickImg = ImagePicker();
  //     final img = await pickImg.pickImage(source: ImageSource.gallery);
  //     if (img != null) {
  //       // setState(() {
  //       globalImage = File(img.path);
  //       // });
  //     } else {
  //       print('Image picking cancelled');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  String titleVal = '';
  String contentVal = '';
  bool allowPost = false;
  bool isImageLoaded = true;

  String chipVal = '';
  void allowUserToSubmitLecture() {
    if (titleVal.length > 2 &&
        titleVal.length < 21 &&
        contentVal.split(' ').length / 2 > 19 &&
        contentVal.split(' ').length / 2 < 280 &&
        chipVal != '') {
      //Chnage params however you like
      allowPost = true;
    } else {
      allowPost = false;
    }
  }

  void dispose() {
    downloadURLFinal = '';
    print(downloadURLFinal);
    super.dispose(); //Clean image when this leaves the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          key: _key, context: context, type: AppBarVariant.arrowLogo),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Text(
              'Create lecture',
              style: Fonts.heading,
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: ColorPalette.dark,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form1.Input(
              labelVariant: FundamentalVariant.dark,
              variant: FundamentalVariant.light,
              placeholder: 'Enter your title:',
              label: 'Title:',

              onChange: (txt) {
                setState(() {
                  titleVal = txt;
                  allowUserToSubmitLecture();
                });
              },
              // label: 'Title:',
              //See with Tonci later if I am going to fix thiss
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 36),
                child: Text(
                  'Content:',
                  style: Fonts.medium.copyWith(shadows: [
                    Shadow(
                        color: ColorPicker.colorOpacity(ColorPicker.dark, 0.25),
                        offset: Offset(0, 2),
                        blurRadius: 4)
                  ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                child: TextFormField(
                    // If you can please make this shadow you understand better than me
                    onChanged: (txt) {
                      setState(() {
                        contentVal = txt;
                        allowUserToSubmitLecture();
                      });
                    },
                    style: Fonts.sm.copyWith(color: ColorPalette.dark),
                    minLines:
                        8, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Enter your content of the page:',
                      hintStyle: Fonts.sm.copyWith(color: ColorPalette.dark),
                      enabledBorder: textFormBorder(ColorPalette.dark),
                      focusedBorder: textFormBorder(ColorPalette.muted),
                    )),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 36, right: 36, top: 14, bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    //Only var need but I have no Idea why flutter doesn't allow me
                    isImageLoaded = false;
                    await choosePic();
                    isImageLoaded = true;
                  },
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose image (optional)',
                          style: Fonts.medium.copyWith(shadows: [
                            Shadow(
                                color: ColorPicker.colorOpacity(
                                    ColorPicker.dark, 0.25),
                                offset: Offset(0, 2),
                                blurRadius: 4)
                          ]),
                        ),
                        const Icon(
                          Icons.image,
                          size: 35,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(
                        color: ColorPalette.dark,
                        thickness: 1,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Choose diffculty:',
                      style: Fonts.medium.copyWith(shadows: [
                        Shadow(
                            color: ColorPicker.colorOpacity(
                                ColorPicker.dark, 0.25),
                            offset: Offset(0, 2),
                            blurRadius: 4)
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RawChip(
                            label: const Text('Begginer',
                                style: TextStyle(color: ColorPalette.light)),
                            backgroundColor: chipVal == 'begginer'
                                ? ColorPalette.success
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'begginer';
                                      allowUserToSubmitLecture();
                                    })
                                  : null;
                              print(chipVal);
                            },
                          ),
                          RawChip(
                            label: const Text('Intermidiate',
                                style: TextStyle(color: ColorPalette.light)),
                            backgroundColor: chipVal == 'intermidiate'
                                ? ColorPalette.success
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'intermidiate';
                                      allowUserToSubmitLecture();
                                    })
                                  : null;
                              print(chipVal);
                            },
                          ),
                          RawChip(
                            label: const Text('Advanced',
                                style: TextStyle(color: ColorPalette.light)),
                            backgroundColor: chipVal == 'advanced'
                                ? ColorPalette.success
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'advanced';
                                      allowUserToSubmitLecture();
                                    })
                                  : null;

                              print(chipVal);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
              // globalImage != null
              //     ? Image.file(globalImage)
              //     : Text('Enter image')
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Container(
                  height: 75,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (allowPost) {
                        print(titleVal);
                        print(contentVal);
                        print(downloadURLFinal);
                        if (isImageLoaded) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lecture(
                                        title: titleVal,
                                        body: contentVal,
                                        nextLecture: Start(),
                                        prevLecture: Start(),
                                        difficultyTag: chipVal,
                                        isUserLection: false,
                                        mockIsCreator: true,
                                      )));
                          // Navigator.push(
                        } else {
                          print(
                              'Waitting for image to be loaded'); //If we can make tast messages or stmh like that
                        }
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Lecture(
                        //               title: titleVal,
                        //               body: contentVal,
                        //               nextLecture: Start(),
                        //               prevLecture: Start(),
                        //               image: downloadURLFinal,
                        //               isUserLection: true,
                        //             )));

                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Home()));
                        // downloadURLFinal = '';
                      } else {
                        print(false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: allowPost
                          ? ColorPalette.successMuted
                          : ColorPalette.muted,
                      onPrimary: ColorPalette.light,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Post',
                      style: Fonts.medium,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
