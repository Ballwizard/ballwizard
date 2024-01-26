import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

User? user = FirebaseAuth.instance.currentUser;

final db = FirebaseFirestore.instance;

String downloadURLFinal = '';

Future<void> addUserWithDoc(
  String title,
  String text,
  String tag,
) async {
  try {
    await db.collection('blog_posts').add({
      'name': user?.displayName,
      'title': title,
      'content': text,
      'isLikedByOthers': false,
      'isLikedByUser': false,
      'tag': tag,
      'numberOfLikes': 0,
      'picture': downloadURLFinal
    });
  } catch (e) {
    print(e);
  }
}

File? globalImage;
final storageRef = FirebaseStorage.instance.ref();
// final metadata = SettableMetadata(contentType: "image/jpeg");
void choosePic() async {
  try {
    final pickImg = ImagePicker();
    final img = await pickImg.pickImage(source: ImageSource.gallery);
    if (img != null) {
      globalImage = File(img.path);
      final sendImg = await storageRef
          .child(
              'blogImages/${DateTime.now()}.png') //I put DateTime.now() change this with some library if we have time
          .putFile(globalImage!);
      final dowURL = await sendImg.ref.getDownloadURL();
      downloadURLFinal = dowURL;
    }
  } catch (e) {
    print(e);
  }
}

chooseProfilePic() async {
  try {
    //If we have time refactor for choose pic and profile pic the image selection
    final pickImg = ImagePicker();
    final img = await pickImg.pickImage(source: ImageSource.gallery);
    if (img != null) {
      globalImage = File(img.path);
      final sendImg = await storageRef
          .child(
              '/profilePictures/${DateTime.now()}.png') //I put DateTime.now()  change this with some library if we have time
          .putFile(globalImage!);
      final dowURL = await sendImg.ref.getDownloadURL();
      await user?.updatePhotoURL(dowURL);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> updateUsername(String username) async {
  try {
    if (user != null && username.length >= 3) {
      // final chnageUsernm =
      await user?.updateDisplayName(username);
      // setState(() {
      //   chnageUsernm;
      // });
      print('Succesfull');
    } else {
      print(false);
    }
  } catch (e) {
    print(e);
  }
}
