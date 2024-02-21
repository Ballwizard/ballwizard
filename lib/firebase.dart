import 'dart:io';

import 'package:ballwizard/types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

User user = FirebaseAuth.instance.currentUser!;

final db = FirebaseFirestore.instance;

String downloadURLFinal = '';

// Manage user
String displayPfpImg = user.photoURL ?? '';
String displayUsername = user.displayName ?? '';

Future<void> addLectureWithDoc(
  String whoDid,
  String title,
  String text,
  String tag,
) async {
  try {
    await db.collection('blog_posts').add({
      'name': user.displayName,
      'title': title.split('')[0].toUpperCase() + title.substring(1),
      'content': text.split('')[0].toUpperCase() + text.substring(1),
      'isLikedByOthers': false,
      'isLikedByUser': false,
      'tag': tag,
      'numberOfLikes': 0,
      'picture': downloadURLFinal,
      'whoDid': whoDid
    });
  } catch (e) {}
}

File? globalImage;
final storageRef = FirebaseStorage.instance.ref();
// final metadata = SettableMetadata(contentType: "image/jpeg");

Future<File?> choosePic() async {
  try {
    final pickImg = ImagePicker();
    final img = await pickImg.pickImage(source: ImageSource.gallery);
    if (img != null) {
      globalImage = File(img.path);
      return globalImage;
    }
  } catch (e) {}
  return null;
}

Future<void> chooseProfilePic() async {
  if (FirebaseAuth.instance.currentUser == null) return;

  try {
    final pickImg = ImagePicker();
    final img = await pickImg.pickImage(source: ImageSource.gallery);
    if (img != null) {
      dynamic crop = await ImageCropper()
              .cropImage(sourcePath: img.path, aspectRatioPresets: [
            CropAspectRatioPreset.square
          ], uiSettings: [
            AndroidUiSettings(
                initAspectRatio: CropAspectRatioPreset.square,
                backgroundColor: ColorPalette.lightMuted,
                toolbarTitle: "Crop your profile picture",
                hideBottomControls: true)
          ]) ??
          img;
      globalImage = File(crop.path);

      final sendImg = await storageRef
          .child(
              '/profilePictures/${FirebaseAuth.instance.currentUser!.uid}.png')
          .putFile(globalImage!);
      final dowURL = await sendImg.ref.getDownloadURL();
      await user.updatePhotoURL(dowURL);

      displayPfpImg = dowURL;
    }
  } catch (e) {}
}

Future<void> updateUsername(String username) async {
  try {
    if (username.length >= 3) {
      await user.updateDisplayName(username);
      displayUsername = username;
    } else {}
  } catch (e) {}
}

Future<List> getDiscoverData(String tag) async {
  final blogPostCollection =
      await db.collection('blog_posts').where('tag', isEqualTo: tag).get();
  List data = [];
  for (var docSnap in blogPostCollection.docs) {
    data.add(docSnap.data());
  }
  return data;
}
