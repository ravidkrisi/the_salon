import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final storage = FirebaseStorage.instance;
  // write file to storage -> download link
  Future<String> uploadFile(String path, File file) async {
    try {
      // get path ref
      final storageRef = storage.ref().child(path);

      // upload file to storage
      await storageRef.putFile(file);

      // get download link
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('failed to upload file to storage: $e');
    }
  }
}
