import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/introduction_1.dart';
import 'package:ballwizard/state/toast.dart';
import 'package:ballwizard/types.dart'
    show
        ColorPalette,
        ColorPicker,
        FundamentalVariant,
        LectureObject,
        RegistrationState,
        Toast,
        ToastVariant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

import 'firebase.dart';

/// Abstract class that is used for all the font styles
/// used in BallWizard.
/// ### Types
/// - xs (10px)
/// - small (14px)
/// - sm (16px)
/// - medium (20px)
/// - large (26px)
/// - heading (32px)
///
/// Types can be either light or regular, light styles
/// are used by adding the suffix -Light to a regular
/// font style.
abstract class Fonts {
  static final TextStyle xs = Font.regular(10);
  static final TextStyle small = Font.regular(14);
  static final TextStyle sm = Font.regular(16);
  static final TextStyle medium = Font.regular(20);
  static final TextStyle large = Font.regular(26);
  static final TextStyle heading = Font.bold(32);

  static final TextStyle xsLight = Font.light(10);
  static final TextStyle smallLight = Font.light(14);
  static final TextStyle smLight = Font.light(16);
  static final TextStyle mediumLight = Font.light(20);
  static final TextStyle largeLight = Font.light(32);
  static final TextStyle headingLight = Font.light(48);

  /// Static method that adds a text shadow to a certain font style.
  static TextStyle addShadow(TextStyle font) {
    return font.merge(TextStyle(shadows: [
      Material.Shadow(
          offset: const Material.Offset(0, 4),
          blurRadius: 4,
          color: ColorPicker.colorOpacity(ColorPicker.dark, 0.33))
    ]));
  }
}

/// A class that is a wrapper to `DropShadow`. Adds a predefined
/// style to DropShadow.
class ShadowElement extends StatelessWidget {
  final dynamic child;
  final FundamentalVariant variant;
  final double blurRadius;
  final double borderRadius;
  final Offset offset;
  final double opacity;
  final double spread;

  const ShadowElement({
    super.key,
    this.child,
    this.variant = FundamentalVariant.dark,
    this.blurRadius = 4,
    this.borderRadius = 0,
    this.offset = const Offset(0, 4),
    this.opacity = 0.25,
    this.spread = 1,
  });

  @override
  Widget build(BuildContext context) {
    return DropShadow(
        child: child,
        color: variant.color(),
        blurRadius: blurRadius,
        borderRadius: borderRadius,
        offset: offset,
        opacity: opacity,
        spread: spread);
  }
}

/// Abstract class that is used in the `Fonts` abstract class.
/// Contains static methods that build font styles by font weight.
abstract class Font {
  static TextStyle regular(double fontSize) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle light(double fontSize) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bold(double fontSize) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }
}

/// Class that returns a gradient background used in a handful
/// of screens.
class GradientBackground extends StatelessWidget {
  final dynamic child;
  final FundamentalVariant variant;

  const GradientBackground({
    super.key,
    this.child,
    this.variant = FundamentalVariant.light,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == FundamentalVariant.light) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorPalette.primary, ColorPalette.secondary],
          ),
        ),
        child: child,
      );
    }

    return Container(
      color: ColorPalette.dark,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorPicker.colorOpacity(ColorPicker.primary, 0.6),
              ColorPicker.colorOpacity(ColorPicker.secondary, 0.6)
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}

/// A map that contains the names of tags used in the database
/// as keys and stylized names of the tags used in the UI as values.
const TAG_MAP = {
  "shooting": "Shooting",
  "dribbling": "Dribbling",
  "passing": "Passing",
  "ball_control": "Ball Control",
  "playmaking": "Playmaking",
  "court_awareness": "Court Awareness",
  "individual": "Individual",
  "scoring": "Scoring",
  "offense": "Offense",
  "finishing": "Finishing",
  "drill": "Drill",
  "spacial_awareness": "Spacial Awareness",
  "defense": "Defense",
  "rebounding": "Rebounding",
  "teamwork": "Teamwork",
  "conditioning": "Conditioning"
};

/// Function that recommends videos for the user based on the
/// `tags` provided in the arguments. Videos which have tags
/// that appear first in the `tags` argument will be ranked more
/// favourably.
Future<List<String>> recommendVideos(tags) async {
  List<String> videos = [];
  Map<String, dynamic> videosMap = {};
  Map<String, dynamic> json =
      jsonDecode(await getJsonFile()) as Map<String, dynamic>;

  for (int i = 0; i < tags.length; i++) {
    final videoTags = json["tags"][tags[i]];
    if (videoTags == null) {
      continue;
    }
    for (int j = 0; j < min(10, videoTags.length); j++) {
      if (videosMap.containsKey(videoTags[j])) {
        videosMap[videoTags[j]] += 1 +
            (tags.length - i - videoTags.length / 2 + Random().nextInt(2)) /
                100;
      } else {
        videosMap[videoTags[j]] = 1 +
            (tags.length - i - videoTags.length / 2 + Random().nextInt(2)) /
                100;
      }
    }
  }

  final sorted = SplayTreeMap.from(
      videosMap, (key1, key2) => videosMap[key2].compareTo(videosMap[key1]));

  sorted.forEach((key, value) => videos.add(key as String));

  return videos;
}

/// Function that returns the list of tags which the user
/// selected in the Introduction screens.
Future<List<String>> getUserTags() async {
  if (FirebaseAuth.instance.currentUser == null) return [];

  final String id = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("user_info");
  final userInfo = await ref.doc(id).get();

  if (!userInfo.exists) return [];

  List tags = userInfo.get("skills_to_improve");

  Map<int, String> tagMap = {
    0: "shooting",
    1: "dribbling",
    2: "passing",
    3: "ball_control",
    4: "playmaking",
    5: "court_awareness",
  };

  List<String> returnList = [];

  for (int i = 0; i < tags.length; i++) {
    if (tags[i] == "false") {
      continue;
    }
    returnList.add(tagMap[i]!);
  }

  final json = jsonDecode(await getJsonFile());

  return [
    ...returnList,
    ...Set.of(json["tag_list"]).difference(Set.of(returnList))
  ];
}

/// Function that returns the view-count of a lecture
/// with the provided id.
Future<int> getLectureViews(String id) async {
  final ref = FirebaseFirestore.instance.collection("lecture");
  final lecture = await ref.doc(id).get();

  if (!lecture.exists) return 0;

  return lecture["count"] ?? 0;
}

/// Function that returns all of the lectures in the cache file.
Future<List<LectureObject>> getAllLectures() async {
  Map<String, dynamic> json =
      jsonDecode(await getJsonFile()) as Map<String, dynamic>;

  final List<LectureObject> lectures = [];

  for (var lecture in json["lectures"]) {
    final int views = await getLectureViews(lecture["lecture_id"]);
    lectures.add(LectureObject(
        id: lecture["lecture_id"],
        content: lecture["content"],
        thumbnail: lecture["thumbnail"],
        title: lecture["title"],
        views: views,
        dateOfCreation: DateTime.parse(lecture["date_of_creation"])));
  }

  return lectures;
}

/// Function that returns the content of the JSON cache file currently saved on the device.
Future<String> getJsonFile() async {
  final dir = await getApplicationCacheDirectory();
  final Directory bw = await Directory("${dir.path}/bw").create();
  final File jsonFile = File("${bw.path}/lectures.json");
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? lastUpdated = prefs.getString("json_update_date");

  if (lastUpdated == null ||
      DateTime.parse(lastUpdated)
          .isBefore(DateTime.now().subtract(const Duration(seconds: 1)))) {
    //CHANGE THIS
    if (!await jsonFile.exists()) {
      await jsonFile.create();
    }
    await FirebaseStorage.instance
        .ref()
        .child("lectures.json")
        .writeToFile(jsonFile);
    await prefs.setString("json_update_date", DateTime.now().toString());
  }

  return await jsonFile.readAsString();
}

/// Function that returns the id of the lecture which has the provided name.
Future<String?> getLectureIdByName(String name) async {
  Map<String, dynamic> json = jsonDecode(await getJsonFile());

  for (var i in json["lectures"]) {
    if (i["title"] == name) return i["id"];
  }

  return null;
}

/// Function that returns a map of all of the lectures grouped
/// into their tags.
Future<Map<String, List<LectureObject>>> getLecturesByTags(
    List<String> tags) async {
  Map<String, List<LectureObject>> lectureMap = {};
  Map<String, dynamic> json = jsonDecode(await getJsonFile());

  for (String tag in tags) {
    final List<LectureObject> lectures = [];
    for (var lecture in json["tags"][tag]) {
      lectures.add(await LectureObject.fromJson(json["id"][lecture]));
    }
    lectureMap[tag] = lectures;
  }

  return lectureMap;
}

/// Function that adds a lecture to the database.
Future<void> createLecture(String userId, String title, String content,
    String difficulty, String? thumbnail, File? thumbnailFile) async {
  final ref = FirebaseFirestore.instance.collection("blog_posts");
  final lectureId = userId +
      String.fromCharCodes(List.generate(
          8,
          (index) =>
              Random().nextInt(33) +
              89)); // create a unique id for every lecture

  final lectureRef = ref.doc(lectureId);
  String dowURL = "";

  if (thumbnailFile != null) {
    final sendImg = await storageRef
        .child('blogImages/$lectureId.png')
        .putFile(thumbnailFile);

    dowURL = await sendImg.ref.getDownloadURL();
  }

  await lectureRef.set({
    "title": title,
    "content": content,
    "thumbnail": dowURL,
    "date_of_creation": DateTime.now().toString(),
    "difficulty": difficulty,
    "numberOfLikes": 0,
    "author": userId,
    "id": lectureId,
  });
}

/// Function that returns all of the comments for a lecture by
/// it's id.
Future<List> fetchComments(String id) async {
  final ref = FirebaseFirestore.instance.collection("blog_posts");
  final comments = await ref.doc(id).get();

  if (!comments.exists) return [];

  try {
    final list = comments.get("comments");
    return list;
  } catch (e) {}

  return [];
}

/// Function that adds a comment as a map to the database record of the lecture.
///
Future<void> addComment(String id, String comment) async {
  final ref = FirebaseFirestore.instance.collection("blog_posts");
  final comments = await ref.doc(id).get();

  if (!comments.exists) return;

  try {
    final list = comments.get("comments");
    list.add({
      "text": comment,
      "user": FirebaseAuth.instance.currentUser!.displayName,
      "id": FirebaseAuth.instance.currentUser!.uid
    });
    await ref.doc(id).set({"comments": list});
  } catch (e) {
    await ref.doc(id).set({
      "comments": [
        {
          "text": comment,
          "user": FirebaseAuth.instance.currentUser!.displayName,
          "id": FirebaseAuth.instance.currentUser!.uid
        }
      ]
    });
  }
}

/// Function that returns all of the lectures that the user
/// has liked.
Future<List> fetchLikedLectures() async {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection("history");

  var historyRef = await ref.doc(FirebaseAuth.instance.currentUser!.uid).get();

  var liked = [];

  if (!historyRef.exists) {
    return [];
  }

  try {
    liked = historyRef.get("liked");
  } catch (e) {
    return [];
  }

  return liked;
}

Future<void> checkIfFullyRegisteredAlready(BuildContext context) async {
  if (FirebaseAuth.instance.currentUser == null) {
    return;
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('user_info').doc(uid);
  DocumentSnapshot docSnapshot = await docRef.get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    if (data['registration_state'] == RegistrationState.complete.code()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
      return;
    }
  }

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const Introduction(),
    ),
  );
}

Future<void> facebookLogin(ToastQueue toastQueue) async {
  try {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  } catch (e) {
    print(e);
    toastQueue.add(Toast(
        variant: ToastVariant.error,
        value: "An error occurred! Please try again in a few minutes."));
  }
}

Future<void> twitterLogin() async {
  TwitterLogin login = TwitterLogin(
      apiKey: "mTUoE4QkhBqOnsEZ1G2f0w6ua",
      apiSecretKey: "hpFkRcfe7aqD86utxOBn7zYAl1TPhQknevrygnnHNhWTH0R2z3",
      redirectURI: "https://ballwizard-app.firebaseapp.com/__/auth/handler");

  // AuthResult auth = await login.login();
  // OAuthCredential creds = TwitterAuthProvider.credential(
  //     accessToken: auth.authToken!, secret: auth.authTokenSecret!);
  // UserCredential user =
  //     await FirebaseAuth.instance.signInWithCredential(creds);
  //  print(user.user?.displayName);

  await login.login().then((value) async {
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: value.authToken!,
      secret: value.authTokenSecret!,
    );

    final data =
        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  });
}

Future<void> googleLogin() async {
  GoogleSignInAccount? user = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? auth = await user?.authentication;
  AuthCredential creds = GoogleAuthProvider.credential(
    //accessToken: auth?.accessToken,
    idToken: auth?.idToken,
    accessToken: auth?.accessToken,
  );
  UserCredential user_instance =
      await FirebaseAuth.instance.signInWithCredential(creds);
}
