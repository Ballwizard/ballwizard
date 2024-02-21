import 'dart:io';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/blog_states.dart';
import 'package:ballwizard/firebase.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;
import 'package:ballwizard/types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Nav extends StatelessWidget {
  final bool renderNavbar;

  const Nav({super.key, this.renderNavbar = true});

  @override
  Widget build(BuildContext context) {
    return const CreateBlog();
  }
}

class CreateBlog extends StatefulWidget {
  final bool renderNavbar;
  const CreateBlog({super.key, this.renderNavbar = true});
  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String downloadURLFinal = "";

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
  File? image;

  String chipVal = '';
  void checkIfCanSubmit() {
    if (titleVal.length > 2 &&
        titleVal.length < 32 &&
        contentVal.split(' ').length / 2 < 350 &&
        chipVal != '') {
      allowPost = true;
    } else {
      allowPost = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          key: _key, context: context, type: AppBarVariant.arrowLogo),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Text(
              'Create lecture',
              style: Fonts.large,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Form1.Input(
              labelVariant: FundamentalVariant.dark,
              variant: FundamentalVariant.light,
              placeholder: 'Enter your title',
              label: 'Title',
              onChange: (txt) {
                setState(() {
                  titleVal = txt;
                  checkIfCanSubmit();
                });
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Content',
                  style: Fonts.small,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: TextFormField(
                    // If you can please make this shadow you understand better than me
                    onChanged: (txt) {
                      setState(() {
                        contentVal = txt;
                        checkIfCanSubmit();
                      });
                    },
                    style: Fonts.small,
                    minLines:
                        8, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'Enter the content of your lecture',
                      hintStyle: Fonts.small.copyWith(color: ColorPalette.dark),
                      enabledBorder: textFormBorder(ColorPalette.dark),
                      focusedBorder: textFormBorder(ColorPalette.muted),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                child: GestureDetector(
                  onTap: () async {
                    isImageLoaded = false;

                    File? file = await choosePic();

                    if (file != null) {
                      setState(() {
                        image = file;
                      });
                    }

                    isImageLoaded = true;
                  },
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.image,
                            size: 24,
                          ),
                        ),
                        Text(
                          'Choose image (optional)',
                          style: Fonts.sm.copyWith(shadows: [
                            Shadow(
                                color: ColorPicker.colorOpacity(
                                    ColorPicker.dark, 0.25),
                                offset: const Offset(0, 2),
                                blurRadius: 4)
                          ]),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Difficulty',
                      style: Fonts.sm.copyWith(shadows: [
                        Shadow(
                            color: ColorPicker.colorOpacity(
                                ColorPicker.dark, 0.25),
                            offset: const Offset(0, 2),
                            blurRadius: 4)
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RawChip(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: chipVal == "beginner"
                                        ? ColorPalette.success
                                        : Colors.transparent)),
                            labelPadding:
                                const EdgeInsets.only(left: 4, right: 4),
                            label: Text('Beginner',
                                style: Fonts.small.merge(const TextStyle(
                                    color: ColorPalette.light))),
                            backgroundColor: chipVal == 'beginner'
                                ? ColorPalette.success
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'beginner';
                                      checkIfCanSubmit();
                                    })
                                  : null;
                            },
                          ),
                          RawChip(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: chipVal == "intermediate"
                                        ? ColorPalette.dark
                                        : Colors.transparent)),
                            labelPadding:
                                const EdgeInsets.only(left: 4, right: 4),
                            label: Text('Intermediate',
                                style: Fonts.small.merge(TextStyle(
                                    color: chipVal == 'intermediate'
                                        ? ColorPalette.dark
                                        : ColorPalette.light))),
                            backgroundColor: chipVal == 'intermediate'
                                ? const Color(0xFFF7F052)
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'intermediate';
                                      checkIfCanSubmit();
                                    })
                                  : null;
                            },
                          ),
                          RawChip(
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: chipVal == "advanced"
                                        ? ColorPalette.danger
                                        : Colors.transparent)),
                            labelPadding:
                                const EdgeInsets.only(left: 4, right: 4),
                            label: Text('Advanced',
                                style: Fonts.small.merge(const TextStyle(
                                    color: ColorPalette.light))),
                            backgroundColor: chipVal == 'advanced'
                                ? ColorPalette.danger
                                : ColorPalette.muted,
                            onSelected: (bool isSelected) {
                              isSelected
                                  ? setState(() {
                                      chipVal = 'advanced';
                                      checkIfCanSubmit();
                                    })
                                  : null;
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SizedBox(
                  height: 75,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (allowPost) {
                        await createLecture(
                            FirebaseAuth.instance.currentUser!.uid,
                            titleVal,
                            contentVal,
                            chipVal,
                            downloadURLFinal,
                            image);
                        if (isImageLoaded) {
                          Navigator.of(context).pop();
                        } else {}
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorPalette.light,
                      backgroundColor:
                          allowPost ? ColorPalette.success : ColorPalette.muted,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
