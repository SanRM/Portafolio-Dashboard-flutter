import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';

class ImageManager extends StatefulWidget {
  final String imageSelected;
  final int indexSelected;

  const ImageManager(
      {required this.imageSelected, required this.indexSelected});

  @override
  State<ImageManager> createState() => _ImageManagerState(
      imageSelected: imageSelected, indexSelected: indexSelected);
}

class _ImageManagerState extends State<ImageManager> {
  final String imageSelected;
  final int indexSelected;

  _ImageManagerState(
      {required this.imageSelected, required this.indexSelected});

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

                              var todaLaInformacion = await getProjects();
                              var listaDeIds = await getDocumentID();
                              

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

                              var imageSelectedFirestoreInfo = await getFileFirestoreName();

                              await removeImage(imageSelectedFirestoreInfo[indexSelected].name);

                              Navigator.pop(context);
                              Navigator.popAndPushNamed(context, '/Galery');
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
