import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

FilePickerResult? selectedFile;
UploadTask? uploadTask;

selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return result;
  }
}

uploadFile() async {
  String? ImageUrl;

  if (selectedFile != null) {
    for (var i = 0; i < selectedFile!.count; i++) {
      final fireStorePath = 'imagenes/${selectedFile!.names[i]}';
      final localPath = File(selectedFile!.paths[i]!);

      final imageRef = FirebaseStorage.instance.ref().child(fireStorePath);
      uploadTask = imageRef.putFile(localPath);

      final snapshot = await uploadTask!.whenComplete(() {});

      ImageUrl = await snapshot.ref.getDownloadURL();
    }

    return ImageUrl;
  }
}
