import "dart:io";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class storageService{

  Future<String> uploadFile(String imagePath, String id) async{

    firebase_storage.Reference storageReference = 
      firebase_storage.FirebaseStorage.instance.ref("users/profile/${id}");

      firebase_storage.UploadTask uploadTask = storageReference.putString(imagePath);

      await uploadTask.whenComplete(() => null);
      String returnURL = '';

      await storageReference.getDownloadURL().then((fileURL){
        returnURL = fileURL;
      });

      return returnURL;
  }
}