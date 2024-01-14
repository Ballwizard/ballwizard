import 'package:ballwizard/blogStates.dart';
import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/createBlog.dart';
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
                          child:
                              Row(children: [Content(), Content(), Content()]),
                        ),
                        Headings('Beginner'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                              Row(children: [Content(), Content(), Content()]),
                        ),
                        Headings('Intermidiate'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                              Row(children: [Content(), Content(), Content()]),
                        ),
                        Headings('Advanced'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                              Row(children: [Content(), Content(), Content()]),
                        ),
                      ],
                    ),
                  )),
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
