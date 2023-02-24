import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CommonFirebaseStorageRepository {
  Future<String> storeFileToFirebase(String ref, File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference reference = storage.ref(ref);

    UploadTask uploadTask = reference.putFile(file);

    final TaskSnapshot snap = await uploadTask.whenComplete(() => null);

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
