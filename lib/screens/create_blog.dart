import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/blog_states.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/content_page.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';
import 'package:ballwizard/input.dart' as Form1 show Input;

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

  String titleVal = '';
  String contentVal = '';
  bool allowPost = false;
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
            padding: const EdgeInsets.only(top: 15),
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
                    onChanged: (txt) {
                      setState(() {
                        contentVal = txt;

                        if (titleVal.length > 3 && contentVal.length > 10) {
                          allowPost = true;
                        } else {
                          allowPost = false;
                        }
                      });
                    },
                    style: Fonts.sm.copyWith(color: ColorPalette.dark),
                    minLines:
                        8, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter your content of the page:',
                      hintStyle: Fonts.sm.copyWith(color: ColorPalette.dark),
                      enabledBorder: textFormBorder(ColorPalette.dark),
                      focusedBorder: textFormBorder(ColorPalette.muted),
                    )),
              ),
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

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContentPage(
                                      titleVal: titleVal,
                                      contentVal: contentVal,
                                      creatorView: true,
                                    )));
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
