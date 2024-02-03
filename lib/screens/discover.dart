import 'package:ballwizard/blog_states.dart';
import 'package:ballwizard/firebase.dart';
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
  List dataBegginer = [];
  List dataIntermidiate = [];
  List dataAdvanced = [];

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List data1 = await getDiscoverData('begginer');
    List data2 = await getDiscoverData('intermidiate');
    List data3 = await getDiscoverData('advanced');
    //I can't call await inside the Row widget it would be 10x ez
    setState(() {
      dataBegginer = data1;
      dataIntermidiate = data2;
      dataAdvanced = data3;
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
                            child: Row(
                                children: dataBegginer.map((dataDoc) {
                              return Content(
                                  context,
                                  dataDoc['whoDid'],
                                  dataDoc['numberOfLikes'],
                                  dataDoc['picture'],
                                  dataDoc['title'],
                                  dataDoc['content']);
                            }).toList()),
                          ),
                          Headings('Beginner'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: dataIntermidiate.map((dataDoc) {
                              return Content(
                                  context,
                                  dataDoc['whoDid'],
                                  dataDoc['numberOfLikes'],
                                  dataDoc['picture'],
                                  dataDoc['title'],
                                  dataDoc['content']);
                            }).toList()),
                          ),
                          Headings('Intermidiate'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: dataBegginer.map((dataDoc) {
                              return Content(
                                  context,
                                  dataDoc['whoDid'],
                                  dataDoc['numberOfLikes'],
                                  dataDoc['picture'],
                                  dataDoc['title'],
                                  dataDoc['content']);
                            }).toList()),
                          ),
                          Headings('Advanced'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: dataAdvanced.map((dataDoc) {
                              return Content(
                                  context,
                                  dataDoc['whoDid'],
                                  dataDoc['numberOfLikes'],
                                  dataDoc['picture'],
                                  dataDoc['title'],
                                  dataDoc['content']);
                            }).toList()),
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
