import 'package:ballwizard/blog_states.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/create_blog.dart';
import 'package:ballwizard/types.dart';
import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GradientBackground(
            variant: FundamentalVariant.light,
            child: GestureDetector(
              child: DefaultTextStyle(
                style: const TextStyle(color: ColorPalette.dark),
                child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Headings('Our recommendation')),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Content(context),
                              Content(context),
                              Content(context)
                            ]),
                          ),
                          Headings('Beginner'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Content(context),
                              Content(context),
                              Content(context)
                            ]),
                          ),
                          Headings('Intermidiate'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Content(context),
                              Content(context),
                              Content(context)
                            ]),
                          ),
                          Headings('Advanced'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Content(context),
                              Content(context),
                              Content(context)
                            ]),
                          ),
                        ],
                      ),
                    )),
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateBlog()));
          },
          // backgroundColor: ColorPalette.dark,
          backgroundColor: ColorPalette.successMuted,
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ));
  }
}
