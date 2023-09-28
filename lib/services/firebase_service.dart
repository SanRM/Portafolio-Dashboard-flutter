import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

CollectionReference projecList = db.collection("Lista de proyectos");
CollectionReference skillsSection = db.collection("Sección de habilidades");
CollectionReference initialInfoSection = db.collection("Información inicial");

Future<List> getProjects() async {
  List projects = [];

  QuerySnapshot querySnapshot = await projecList.get();

  for (var documento in querySnapshot.docs) {
    projects.add(documento.data());
  }

  return projects;
}

Future<List> getSkills() async {
  List skills = [];

  QuerySnapshot querySnapshot = await skillsSection.get();

  for (var documento in querySnapshot.docs) {
    skills.add(documento.data());
  }

  return skills;
}

Future<List> getInitialInfo() async {
  List initialInfo = [];

  QuerySnapshot querySnapshot = await initialInfoSection.get();

  for (var documento in querySnapshot.docs) {
    initialInfo.add(documento.data());
  }

  return initialInfo;
}

Future<List> getWhiteList() async {
  List whiteList = [];

  CollectionReference collectionReference =
      db.collection("Lista blanca de usuarios");

  QuerySnapshot querySnapshot = await collectionReference.get();

  for (var documento in querySnapshot.docs) {
    whiteList.add(documento.data());
  }

  return whiteList;
}

Future<List> getDocumentID() async {
  List<String> projectsIds = [];

  QuerySnapshot querySnapshot = await projecList.get();

  for (var element in querySnapshot.docs) {
    projectsIds.add(element.id);
  }

  return projectsIds;
}

Future<List> getDocumentSkillsID() async {
  List<String> documentIds = [];

  QuerySnapshot querySnapshot = await skillsSection.get();

  for (var element in querySnapshot.docs) {
    documentIds.add(element.id);
  }

  return documentIds;
}

Future<List> getInitialInfoID() async {
  List<String> documentIds = [];

  QuerySnapshot querySnapshot = await initialInfoSection.get();

  for (var element in querySnapshot.docs) {
    documentIds.add(element.id);
  }

  return documentIds;
}

Future<void> updateSkills(String projectID, Map<String, dynamic> informationToEdit) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    DocumentReference docRef = FirebaseFirestore.instance.collection('Sección de habilidades').doc(projectID);

    print(informationToEdit);

    // Método update para actualizar el documento con el mapa completo
    await docRef.update(informationToEdit);

    print('Documento editado con éxito');
  } catch (error) {
    print('Error al editar el documento: $error');
  }
}

Future<void> updatePrincipalImage(String documentID, String principalImage) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    DocumentReference docRef = FirebaseFirestore.instance.collection('Información inicial').doc(documentID);

    Map<String, dynamic> conversion = {
      "principalBanner": principalImage,
    };

    //print(conversion);

    // Utiliza el método set con la opción merge para actualizar los campos específicos
    await docRef.set(conversion, SetOptions(merge: true));

    //print('Documento editado con éxito');
  } catch (error) {
    //print('Error al editar el documento: $error');
  }
}

Future<void> updateLateralImage(String projectID, String lateralImage) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    DocumentReference docRef = FirebaseFirestore.instance.collection('Sección de habilidades').doc(projectID);

    Map<String, dynamic> conversion = {
      "Imagen lateral": lateralImage,
    };

    //print(conversion);

    // Utiliza el método set con la opción merge para actualizar los campos específicos
    await docRef.set(conversion, SetOptions(merge: true));

    //print('Documento editado con éxito');
  } catch (error) {
    //print('Error al editar el documento: $error');
  }
}

Future<void> updateProjectBanner(String projectID, String projectBanner) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Lista de proyectos')
        .doc(projectID);

    Map<String, dynamic> conversion = {
      "projectBanner": projectBanner,
    };

    //print(conversion);

    // Utiliza el método set con la opción merge para actualizar los campos específicos
    await docRef.set(conversion, SetOptions(merge: true));

    //print('Documento editado con éxito');
  } catch (error) {
    //print('Error al editar el documento: $error');
  }
}

Future<void> updateDocument(
    String projectID,
    int cardBgColor,
    String projectBanner,
    String projectDescription,
    List projectLabels,
    List projectLinks,
    String projectTitle) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Lista de proyectos')
        .doc(projectID);

    Map<String, dynamic> conversion = {
      "cardBgColor": cardBgColor,
      "projectBanner": projectBanner,
      "projectDescription": projectDescription,
      "projectLabels": projectLabels,
      "projectLinks": projectLinks,
      "projectTitle": projectTitle,
    };

    //print(conversion);

    // Utiliza el método set con la opción merge para actualizar los campos específicos
    await docRef.set(conversion);

    //print('Documento editado con éxito');
  } catch (error) {
    //print('Error al editar el documento: $error');
  }
}

Future<void> addDocument(
    int cardBgColor,
    String projectBanner,
    String projectDescription,
    List projectLabels,
    List projectLinks,
    String projectTitle) async {
  try {
    // Obtiene una referencia al documento que deseas editar

    Map<String, dynamic> conversion = {
      "cardBgColor": cardBgColor,
      "projectBanner": projectBanner,
      "projectDescription": projectDescription,
      "projectLabels": projectLabels,
      "projectLinks": projectLinks,
      "projectTitle": projectTitle,
    };
    // Utiliza el método set con la opción merge para actualizar los campos específicos
    await db.collection("Lista de proyectos").add(conversion);

    //print('Documento creado con éxito');
  } catch (error) {
    //print('Error al crear el documento: $error');
  }
}

Future<void> deleteDocument(String projectID) async {
  try {
    // Obtiene una referencia al documento que deseas editar
    // Utiliza el método set con la opción merge para actualizar los campos específicos
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('Lista de proyectos')
        .doc(projectID);

    await docRef.delete();

    //print('Documento eliminado con éxito');
  } catch (error) {
    //print('Error al eliminado el documento: $error');
  }
}
