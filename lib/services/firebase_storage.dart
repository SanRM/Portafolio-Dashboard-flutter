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

uploadFile(folder) async {
  String? imageUrl;

  if (selectedFile != null) {
    for (var i = 0; i < selectedFile!.count; i++) {
      final fireStorePath = '$folder/${selectedFile!.names[i]}';
      final localPath = File(selectedFile!.paths[i]!);

      final imageRef = FirebaseStorage.instance.ref().child(fireStorePath);
      uploadTask = imageRef.putFile(localPath);

      final snapshot = await uploadTask!.whenComplete(() {});

      imageUrl = await snapshot.ref.getDownloadURL();
    }

    return imageUrl;
  }
}

Future<List<Reference>> getFileFirestoreName(folder) async {
  List<Reference> imageReferences = [];

  final storageReference = FirebaseStorage.instance.ref().child(folder);

  try {
    final ListResult result = await storageReference.listAll();

    for (final Reference ref in result.items) {
      imageReferences.add(ref);
    }
  } catch (e) {
    // Maneja cualquier error que pueda ocurrir al obtener las referencias de las imágenes.
    //print('Error al obtener las referencias de las imágenes: $e');
  }

  return imageReferences;
}

Future<void> removeImage(String imageUrl, folder) async {
  final storageReference = FirebaseStorage.instance.ref();

  try {
    // Obtén una referencia a la imagen que deseas eliminar por su URL.
    final imageReference = storageReference.child(folder).child(imageUrl);

    // Elimina la imagen.
    await imageReference.delete();

    //print('Imagen eliminada exitosamente: $imageUrl');
  } catch (e) {
    // Maneja cualquier error que pueda ocurrir al eliminar la imagen.
    //print('Error al eliminar la imagen: $e');
  }
}

Future<List<String>> getUrlImageList(folder) async {
  List<String> downloadUrls = [];

  final storageReference = FirebaseStorage.instance.ref().child(folder);

  try {
    final ListResult result = await storageReference.listAll();

    for (final Reference ref in result.items) {
      String imageUrl = await ref.getDownloadURL();
      downloadUrls.add(imageUrl);
    }
  } catch (e) {
    // Maneja cualquier error que pueda ocurrir al obtener las imágenes.
    //print('Error al obtener las imágenes: $e');
  }

  return downloadUrls;
}

Future<List<String>> getAllPersonalImagesUrls() async {
  List<String> downloadUrls = [];

  final storageReference =
      FirebaseStorage.instance.ref().child('imagenes personales');

  try {
    final ListResult result = await storageReference.listAll();

    for (final Reference ref in result.items) {
      String imageUrl = await ref.getDownloadURL();
      downloadUrls.add(imageUrl);
    }
  } catch (e) {
    // Maneja cualquier error que pueda ocurrir al obtener las imágenes.
    //print('Error al obtener las imágenes: $e');
  }

  return downloadUrls;
}

Future<List<String>> getAllLabelsUrls() async {
  List<String> downloadUrls = [];

  final storageReference = FirebaseStorage.instance.ref().child('insignias');

  try {
    final ListResult result = await storageReference.listAll();

    for (final Reference ref in result.items) {
      String imageUrl = await ref.getDownloadURL();
      downloadUrls.add(imageUrl);
    }
  } catch (e) {
    // Maneja cualquier error que pueda ocurrir al obtener las imágenes.
    //print('Error al obtener las imágenes: $e');
  }

  return downloadUrls;
}
