import "dart:ffi";
import "dart:typed_data";

import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:firebase_database/firebase_database.dart";

final FirebaseDatabase database = FirebaseDatabase.instance;
final DatabaseReference databaseref = FirebaseDatabase.instance.ref();
final FirebaseStorage storage = FirebaseStorage.instance;
final currentUser = FirebaseAuth.instance.currentUser!;
final userCollection = FirebaseDatabase.instance.ref('users');

class StoreData {
  Future<String> uploadImage2Storage(
      String childName, Uint8List file, String id) async {
    Reference ref = storage.ref().child(childName).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> storeImageToUser(Uint8List file) async {

    String imageUrl = await uploadImage2Storage('profileImages', file, currentUser.email!
              .replaceAll('.', '_')
              .replaceAll('@', '_')
              .replaceAll('#', '_'));
              
    await userCollection
        .child(currentUser.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'))
        .update({'profileImage': imageUrl});
  }
}
