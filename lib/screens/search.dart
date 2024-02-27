// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:ballwizard/appbar.dart';
import 'package:ballwizard/types.dart' show ColorPalette, AppBarVariant;
import 'package:flutter/material.dart';

import '../card.dart';
import '../globals.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String inputVal = "";
  Map<String, dynamic>? json;
  List<Map<String, dynamic>> items = [];

  search(String searchStr) async {
    String str = await getJsonFile();
    setState(() {
      json = jsonDecode(str) as Map<String, dynamic>;
    });
    items = [];
    for (var lecture in json?["lectures"]) {
      if (lecture["title"].toLowerCase().contains(searchStr)) {
        setState(() {
          items.add(lecture);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          key: _key,
          context: context,
          type: AppBarVariant.search,
          onInputChange: (String val) {
            setState(() {
              inputVal = val;
            });
          },
          onEnter: (String val) async {
            await search(inputVal.toLowerCase());
          },
          placeholder: "Search"),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Flexible(
                child: ListView(
                    children: items
                        .map<Widget>((lecture) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: ColorPalette.muted,
                                        spreadRadius: -1,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: CardElement(
                                    markdown: lecture["content"],
                                    thumbnail: lecture["thumbnail"],
                                    title: lecture["title"],
                                    id: lecture["lecture_id"],
                                    author: lecture["author"],
                                    dateOfCreation: DateTime.parse(
                                        lecture["date_of_creation"])),
                              ),
                            ))
                        .toList())),
          ],
        ),
      ),
    );
  }
}
