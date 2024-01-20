import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? user = FirebaseAuth.instance.currentUser;

final db = FirebaseFirestore.instance;

Future<void> addUserWithDoc(String title, String text, String tag,
    {String pic = ''}) async {
  try {
    await db.collection('blog_posts').add({
      'name': user?.displayName,
      'title': title,
      'content': text,
      'isLikedByOthers': false,
      'isLikedByUser': false,
      'tag': tag,
      'numberOfLikes': 0,
      'picture': pic
    });
  } catch (e) {
    print(e);
  }
}
