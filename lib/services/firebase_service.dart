import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

CollectionReference projecList = db.collection("Lista de proyectos");

Future<bool> addBandejaDeEntrada(
    String name, String email, String message) async {
  Map<String, dynamic> conversion = {
    "nombre": name,
    "email": email,
    "mensaje": message
  };

  try {
    await db.collection("Bandeja de entrada").add(conversion);
    print('Operación exitosa: Mensaje enviado correctamente');
    return true;
  } catch (e) {
    print('Error al enviar el mensaje: $e');
    return false;
  }
}

Future<List> getProjects() async {
  List projects = [];

  QuerySnapshot querySnapshot = await projecList.get();

  querySnapshot.docs.forEach((documento) {
    projects.add(documento.data());
  });

  return projects;
}

Future<List> getWhiteList() async {
  List whiteList = [];

  CollectionReference collectionReference = db.collection("Lista blanca de usuarios");

  QuerySnapshot querySnapshot = await collectionReference.get();

  querySnapshot.docs.forEach((documento) {
    documento.id;
    whiteList.add(documento.data());
  });

  return whiteList;
}

getDocumentID() async {

  List projectsIds = [];

  QuerySnapshot querySnapshot = await projecList.get();

  querySnapshot.docs.forEach((element) { 
    print(element.id);
    projectsIds.add(element.id);
  });

  return projectsIds;

}

editDocumentInfo(id) async {

  var docRef = db.collection("Lista de proyectos").doc();

  print(docRef.id);

}