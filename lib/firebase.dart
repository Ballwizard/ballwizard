import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

// choosePic() async {
//   try {
//     final pickImg = ImagePicker();
//     final img = await pickImg.pickImage(source: ImageSource.gallery);
//     if (img != null) {
//       // setState(() {\

//       globalImage = File(img.path);
//       storageRef.child('gs://ballwizard-app.appspot.com/blogImages');
//       // });
//     } else {
//       print('Image picking cancelled');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
String downloadURLFinal = '';

File? globalImage;
final storageRef = FirebaseStorage.instance.ref();
// final metadata = SettableMetadata(contentType: "image/jpeg");
choosePic() async {
  try {
    final pickImg = ImagePicker();
    final img = await pickImg.pickImage(source: ImageSource.gallery);
    if (img != null) {
      globalImage = File(img.path);
      final sendImg = await storageRef
          .child('blogImages/${DateTime.now()}.png') //I put DateTime.now()
          .putFile(globalImage!);
      final snapshot = await sendImg;
      final dowURL = await snapshot.ref.getDownloadURL();
      downloadURLFinal = dowURL;
    } else {
      print('Image picking cancelled');
    }
  } catch (e) {
    print(e);
  }
}
