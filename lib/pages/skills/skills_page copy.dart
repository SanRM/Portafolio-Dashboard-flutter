import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20image%20selector/galery_image_selector.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  File? finalImageLocalPath;
  File? finalBadgeImageLocalPath;
  String? imageSelected;
  bool? bannerChanged;
  String lateralImage = "default";
  bool? imageChanged;
  bool? insigniaChanged;

  int? indexToChange;

  int badgesCount = 0;

  removeButton() {
    setState(() {
      badgesCount -= 1;
    });
  }

  addButton() {
    setState(() {
      badgesCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Habilidades'),
      ),
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      body: FutureBuilder(
        future: getSkillsSection(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data);

            if (imageChanged == false) {
              lateralImage = snapshot.data?[0]['Imagen lateral'];
            }

            var personalDescription = snapshot.data?[0]['Descripcion'];

            var insignias = snapshot.data?[0]['Insignias'];

            print(
                "lateralImage: $lateralImage, personalDescription: $personalDescription");

            //return Container();

            return Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                alignment: Alignment.center,
                child: ListView(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 15, right: 15, left: 15),
                            child: Text(
                              'Imágen lateral',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2),
                              ),
                              child: lateralImage == 'default'
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: finalImageLocalPath == null
                                          ? Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%20personales%2FPersonalData.png?alt=media&token=1c94cb6b-3f64-436d-9dce-cd8d70fb02c3',
                                              fit: BoxFit.cover)
                                          : Image.file(finalImageLocalPath!,
                                              fit: BoxFit.cover),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: finalImageLocalPath == null
                                          ? Image.network(lateralImage,
                                              fit: BoxFit.cover)
                                          : Image.file(finalImageLocalPath!,
                                              fit: BoxFit.cover),
                                    ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: IconButton.filledTonal(
                                  onPressed: () {
                                    setState(() {
                                      lateralImage = 'default';
                                      finalImageLocalPath = null;
                                      selectedFile = null;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.icon(
                                  onPressed: () async {
                                    selectedFile = await selectFile();

                                    if (selectedFile != null) {
                                      final imageLocalPath =
                                          File(selectedFile!.paths[0]!);

                                      setState(
                                        () {
                                          bannerChanged = true;
                                          finalImageLocalPath = imageLocalPath;
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.file_upload_outlined),
                                  label: const Text('Subir'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.icon(
                                  onPressed: () async {
                                    imageSelected = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const GaleryImageSelector();
                                        },
                                      ),
                                    );

                                    if (imageSelected != null) {
                                      setState(() {
                                        imageChanged = true;
                                        finalImageLocalPath == null;
                                        lateralImage = imageSelected!;
                                      });
                                    }

                                    print(lateralImage);
                                    print("imageChanged: $imageChanged");

                                    //print(imageSelected);
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Galeria'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 15, left: 15),
                            child: Text(
                              'Descripción personal',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  personalDescription = value;
                                });
                              },
                              maxLines: 5,
                              initialValue: personalDescription,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                label: const Text('Descripción'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Insignias',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: (badgesCount + insignias.length).toInt(),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                              

                              final totalBadges = insignias.length;

                              var imagenInsignia = "default";

                              if (index < totalBadges) {
                                imagenInsignia = insignias[index]["ImageUrl"];
                                print("Campo ya existente, INDEX: $index, TOTALBADGES: $totalBadges");
                              }
                              
                              if (index > totalBadges) {
                                imagenInsignia = "default";
                                print("Nuevo campo, INDEX: $index, TOTALBADGES: $totalBadges");
                              }

                              if (indexToChange == index) {
                                print('La imagen con el index $index debe cambiar');
                              }

                              // print(totalBadges);
                              // print(index);

                              return Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double containerWidth =
                                        constraints.maxWidth;
                                    return Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                          .withOpacity(0.5),
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceAround,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border:
                                                        Border.all(width: 2),
                                                  ),
                                                  child: imagenInsignia == 'default'

                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: finalBadgeImageLocalPath == null
                                                              ? Padding(
                                                                  padding: const EdgeInsets.all(10),
                                                                  child: Image.network(
                                                                      'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/insignias%2Fmedalla.png?alt=media&token=e8d91863-d857-4873-9d3c-4d71b6fc0ac9',
                                                                      fit: BoxFit.contain),
                                                                )
                                                              : Image.file(
                                                                  finalBadgeImageLocalPath!,
                                                                  fit: BoxFit.cover),
                                                        )

                                                      : ClipRRect(
                                                          borderRadius:BorderRadius.circular(10),
                                                          child: finalBadgeImageLocalPath == null
                                                              ? Image.network(
                                                                  imagenInsignia,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image.file(
                                                                  finalBadgeImageLocalPath!,
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),

                                                ),
                                                Wrap(
                                                  alignment:
                                                      WrapAlignment.center,
                                                  children: [

                                                    //6. REMOVE BADGE IMAGE

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: IconButton
                                                          .filledTonal(
                                                        onPressed: () {
                                                          setState(() {
                                                            imagenInsignia = 'default';
                                                            finalBadgeImageLocalPath = null;
                                                            selectedFile = null;
                                                          });
                                                        },
                                                        icon: const Icon(Icons
                                                            .remove_circle),
                                                      ),
                                                    ),

                                                    //6. UPLOAD BADGE IMAGE

                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15),
                                                      child: IconButton.filled(
                                                        onPressed: () async {
                                                          selectedFile = await selectFile();

                                                          if (selectedFile != null) {
                                                            final imageLocalPath = File(selectedFile!.paths[0]!);

                                                            setState(() {
                                                                bannerChanged = true;
                                                                indexToChange = index;
                                                                print(indexToChange);

                                                                finalBadgeImageLocalPath = imageLocalPath;
                                                              },
                                                            );
                                                          }

                                                        },
                                                        icon: const Icon(Icons
                                                            .file_upload_outlined),
                                                      ),
                                                    ),

                                                    //6. SELECT BADGE IMAGE FROM GALERY

                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 15),
                                                      child: IconButton.filled(
                                                        onPressed: () async {
                                                          imageSelected = await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return const GaleryImageSelector();
                                                              },
                                                            ),
                                                          );

                                                          if (imageSelected != null) {
                                                            setState(() {
                                                              imageChanged = true;
                                                              finalBadgeImageLocalPath == null;
                                                              imagenInsignia = imageSelected!;
                                                            });
                                                          }

                                                          print(imagenInsignia);
                                                          print("imageChanged: $imageChanged");

                                                          //print(imageSelected);
                                                        },
                                                        icon: const Icon(Icons.image),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   color: Colors.black,
                                          //   width: 0.5,
                                          //   height: 100,
                                          // ),
                                          SizedBox(
                                            width: containerWidth / 2.5,
                                            child: TextFormField(
                                              onSaved: (value) {
                                                // Map mapMerged = {};
                                                // Map projectButtonsNameMap = {};
                                                // Map projectButtonsUrlMap = {};

                                                // var projectButtonsUrlListEmpty;

                                                // projectButtonsUrlListEmpty.add(value);

                                                // for (int i = 0; i < projectButtonsUrlListEmpty.length; i++) {
                                                //   var projectButtonsUrlMap;
                                                //   projectButtonsUrlMap['url'] = projectButtonsUrlListEmpty[i];
                                                // }

                                                // mapMerged = {
                                                //   ...projectButtonsNameMap,
                                                //   ...projectButtonsUrlMap
                                                // };

                                                // var buttonsListFinished;
                                                // buttonsListFinished.add(mapMerged);

                                                // print('Botones del proyecto (url map) as Map: $projectButtonsUrlMap');
                                              },
                                              initialValue: imagenInsignia !=
                                                      "default"
                                                  ? "${insignias[index]["nombre"]}"
                                                  : "",
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.black)),
                                                label:
                                                    Text('Titulo ${index + 1}'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.tonalIcon(
                                  onPressed: () {
                                    setState(() {
                                      insigniaChanged = true;
                                    });
                                    removeButton();
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                  label: const Text('Eliminar'),
                                  style: const ButtonStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      insigniaChanged = true;
                                    });
                                    addButton();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text('Agregar'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
