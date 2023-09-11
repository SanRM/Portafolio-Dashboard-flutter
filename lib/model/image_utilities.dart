import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';

class ImageManager extends StatefulWidget {
  final String imageSelected;
  final int indexSelected;

  const ImageManager({required this.imageSelected, required this.indexSelected});

  @override
  State<ImageManager> createState() =>
      _ImageManagerState(imageSelected: imageSelected, indexSelected: indexSelected);
}

class _ImageManagerState extends State<ImageManager> {
  final String imageSelected;
  final int indexSelected;

  _ImageManagerState({required this.imageSelected, required this.indexSelected});

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
                        title: Text('Confirmar eliminación de imágen'),
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
                            child: Text('Cancelar'),
                          ),
                          FilledButton(
                            onPressed: () async {
                              var imageSelectedFirestoreName = await getFileFirestoreName();
                              await removeImage(imageSelectedFirestoreName[indexSelected].name);
                              Navigator.pop(context);
                              Navigator.popAndPushNamed(context, '/Galery');
                            },
                            child: Text('Confirmar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.remove_circle),
                color: Colors.black.withOpacity(0.7),
              ),
            )
          ],
        );
      },
    );
  }
}
