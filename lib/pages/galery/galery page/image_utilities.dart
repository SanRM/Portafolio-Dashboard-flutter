// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';

class ImageManager extends StatefulWidget {
  final String imageSelected;
  final int indexSelected;
  final String galeryType;

  const ImageManager(
      {required this.imageSelected,
      required this.indexSelected,
      required this.galeryType});

  @override
  State<ImageManager> createState() => _ImageManagerState(
      imageSelected: imageSelected,
      indexSelected: indexSelected,
      galeryType: galeryType);
}

class _ImageManagerState extends State<ImageManager> {
  final String imageSelected;
  final int indexSelected;
  final String galeryType;

  _ImageManagerState(
      {required this.imageSelected,
      required this.indexSelected,
      required this.galeryType});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              width: screenWidth / 2.1,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageSelected,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 5,
              child: IconButton(
                onPressed: () {
                  //print(imageSelectedFirestorePath[0].fullPath);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmar eliminación de imágen'),
                        content: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          width: screenWidth / 2.1,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              imageSelected,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        actions: [
                          FilledButton.tonal(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              //String insignias = "insignias";

                              if (galeryType == "imagenes") {
                                var todaLaInformacion = await getCollectionInfo("Lista de proyectos");
                                var listaDeIds = await getDocumentID("Lista de proyectos");

                                for (var i = 0; i < todaLaInformacion.length; i++) {
                                  var todaLaInformacionItem = todaLaInformacion[i]['projectBanner'];

                                  if (todaLaInformacionItem == 'default') {
                                    todaLaInformacionItem = 'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%2FDefault%20project%20banner.png?alt=media&token=d3613ab9-ae8e-4803-ada4-43c70248e7cc';
                                  }

                                  if (todaLaInformacionItem == imageSelected) {
                                    //print('La imagen: $imageSelected está repetida');
                                    //print('El id del proyecto de la imagen repetida es: ${listaDeIds[i]}');
                                    updateProjectBanner(listaDeIds[i], 'default');
                                  } else {
                                    //print('No hay imagenes repetidas');
                                  }
                                }

                                //print(imagenRepetida);

                                var imageSelectedFirestoreInfo = await getFileFirestoreName(galeryType);

                                //print(imageSelectedFirestoreInfo[indexSelected].name);

                                await removeImage(imageSelectedFirestoreInfo[indexSelected].name, galeryType);

                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, '/Galery');
                              }


                              if (galeryType == "imagenes personales") {
                                //print(galeryType);

                                var todaLaInformacionSkills = await getCollectionInfo("Sección de habilidades");
                                var listaDeIds = await getDocumentID("Lista de proyectos");

                                for (var i = 0; i < todaLaInformacionSkills.length; i++) {
                                  var todaLaInformacionItem = todaLaInformacionSkills[i]['Imagen lateral'];

                                  if (todaLaInformacionItem == 'default') {
                                    todaLaInformacionItem = 'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%20personales%2FPersonalData.png?alt=media&token=1c94cb6b-3f64-436d-9dce-cd8d70fb02c3';
                                  }

                                  //if (todaLaInformacionItem == imageSelected) {
                                    //print('La imagen: $imageSelected está repetida');
                                    //print('El id del proyecto de la imagen repetida es: ${listaDeIds[i]}');
                                    updateLateralImage(listaDeIds[i], 'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%20personales%2FPersonalData.png?alt=media&token=1c94cb6b-3f64-436d-9dce-cd8d70fb02c3');
                                  //} else {
                                    //print('No hay imagenes repetidas');
                                  //}
                                }

                                var imageSelectedFirestoreInfo = await getFileFirestoreName(galeryType);

                                //print(imageSelectedFirestoreInfo[indexSelected].name);

                                await removeImage(imageSelectedFirestoreInfo[indexSelected].name, galeryType);

                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, '/Galery');
                              }

                              if (galeryType == "insignias") {
                                //print(galeryType);

                                var imageSelectedFirestoreInfo = await getFileFirestoreName(galeryType);

                                //print(imageSelectedFirestoreInfo[indexSelected].name);

                                await removeImage(imageSelectedFirestoreInfo[indexSelected].name, galeryType);

                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, '/Galery');
                              }
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.remove_circle),
                color: Colors.black.withOpacity(0.7),
              ),
            )
          ],
        );
      },
    );
  }
}
