import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

class StorageServices {
  //Upload user profile method
  Future<String> uploadProfileImage(File image) async {
    String imageUrl;
    try {
      // Path of the picture
      String fileName = basename(image.path);

      // Referene to the firebase storage or reference to the bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('userProfilePicture/$fileName');

      // Put the file in the bucket above
      final UploadTask uploadTask = storageReference.putFile(image);
      // Getting image url
      final TaskSnapshot downloadUrl = (await uploadTask);
      // Url of the file in the storage
      imageUrl = await downloadUrl.ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  //Deletes and uploads image to storage
  //Calls the function uploadProfileImage()
  Future<String> deleteAndUploadImg(String imageUrl, File image) async {
    String newImageUrl;
    try {
      if (imageUrl != 'noImage') {
        final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
        await storageRef.delete();
      }
      newImageUrl = await uploadProfileImage(image);
    } catch (e) {
      print(e);
    }
    return newImageUrl;
  }
}
