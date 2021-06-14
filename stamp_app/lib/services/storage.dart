import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

class StorageServices {
  //Upload user profile method
  Future<String> uploadProfileImage(File image) async {
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
    final String imageUrl = await downloadUrl.ref.getDownloadURL();
    return imageUrl;
  }
}
