import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20selectors/badges_selector.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20selectors/personal_images_selector.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

List<String> badgesImageListEmpty = [];
List<String> badgesNameListEmpty = [];
bool badgesImageChanged = false;

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
  String lateralImage = "https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%20personales%2FPersonalData.png?alt=media&token=1c94cb6b-3f64-436d-9dce-cd8d70fb02c3";
  String personalDescription = "Descripción personal";
  bool imageChanged = false;
  bool? insigniaChanged;

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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Habilidades'),
      ),
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      body: FutureBuilder(
        future: getCollectionInfo("Sección de habilidades"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data);

            if (imageChanged == false) {
              lateralImage = snapshot.data?[0]['Imagen lateral'];
            }

            personalDescription = snapshot.data?[0]['Descripcion'];

            var insignias = snapshot.data?[0]['Insignias'];

            //print("lateralImage: $lateralImage, personalDescription: $personalDescription");

            //return Container();

            return Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
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
                                child: ClipRRect(
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
                                        bannerChanged = false;
                                        lateralImage = snapshot.data?[0]['Imagen lateral'];
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
                                            return const GaleryPersonalImagesSelector();
                                          },
                                        ),
                                      );
                
                                      if (imageSelected != null) {
                                        setState(() {
                                          imageChanged = true;
                                          finalImageLocalPath = null;
                                          lateralImage = imageSelected!;
                                        });
                                      }
                
                                      //print(lateralImage);
                                      //print("imageChanged: $imageChanged");
                
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
                                onSaved: (newValue) {
                                    personalDescription = newValue!;
                                    // print("personalDescription: $personalDescription");
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
                            LayoutBuilder(
                              builder: (BuildContext context,BoxConstraints constraints) {
                                List<Widget> finalBadgesWidgetsList = [];
                
                                for (var i = 0; i < insignias.length + badgesCount; i++) {
                                  if (i < insignias.length) {
                                    finalBadgesWidgetsList.add(Badges(insignia: insignias[i], actualIndex: i));
                                  } else {
                                    finalBadgesWidgetsList.add(Badges(insignia: const {
                                      "ImageUrl": "https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/insignias%2Fmedalla.png?alt=media&token=e8d91863-d857-4873-9d3c-4d71b6fc0ac9",
                                      "nombre": ""
                                    }, actualIndex: i));
                                  }
                
                                  //print(insignias[0]);
                                }
                
                                return Column(children: finalBadgesWidgetsList);
                                //return Container();
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
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton.icon(
                        onPressed: () async {
                
                          formKey.currentState?.save();
                
                          // print("");
                          // print("Imágen lateral: $lateralImage");
                          // print('Descripción personal: $personalDescription');
                          List<Map<String, dynamic>> badgesListMerged = []; 

                          for (int i = 0; i < badgesImageListEmpty.length; i++) {

                            Map<String, dynamic> finalBadgesList = {
                              'ImageUrl': badgesNameListEmpty[i],
                              'nombre': badgesImageListEmpty[i]
                            };

                            badgesListMerged.add(finalBadgesList);

                            //print("BadgesListMerged: $badgesListMerged");

                          }

                          if (bannerChanged == true) {
                            var projectBannerTemp = await uploadFile('imagenes personales');

                            setState(() {
                              lateralImage = projectBannerTemp;
                            });
                          }

                          Map<String, dynamic> lateralImageMap = {
                            'Imagen lateral': lateralImage,
                          };

                          Map<String, dynamic> personalDescriptionMap = {
                            'Descripcion': personalDescription,
                          };

                          Map<String, dynamic> finalBadgesListNamed = {
                            'Insignias': badgesListMerged,
                          };

                          // print('Imagen lateral: $lateralImageMap');
                          // print("personalDescription $personalDescriptionMap");
                          // print("BadgesListMerged: $BadgesListMerged");

                          Map<String, dynamic> mapMerged = {
                            ...finalBadgesListNamed,
                            ...lateralImageMap,
                            ...personalDescriptionMap,
                          };

                          //print("getSkillsSection: ${skillsSection[0]['Insignias']}");

                          var documentSkillsID = await getDocumentID("Lista de proyectos");

                          //print("getSkillsSection: ${skillsSection[0]}");

                          //print("DocumentSkillsID: ${documentSkillsID[0]}");

                          //print("finalBadgesListNamed: $finalBadgesListNamed");

                          //print("mapMerged: $mapMerged");

                          updateSkills(documentSkillsID[0], mapMerged);

                          badgesImageListEmpty = [];
                          badgesNameListEmpty = [];
                          
                          Navigator.popAndPushNamed(context, '/Skills');
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Badges extends StatefulWidget {
  final Map insignia;
  final int actualIndex;

  Badges({super.key, required this.insignia, required this.actualIndex});

  @override
  State<Badges> createState() =>
      _BadgesState(insignia: insignia, actualIndex: actualIndex);
}

class _BadgesState extends State<Badges> {
  final Map insignia;
  final int actualIndex;

  _BadgesState({required this.insignia, required this.actualIndex});

  String imagenInsignia = "default";
  File? finalBadgeImageLocalPath;
  String? imageSelected;
  bool? imageChanged;

  late String badgeImageUrl;

  @override
  void initState() {
    super.initState();
    badgeImageUrl = insignia["ImageUrl"];
  }

  @override
  Widget build(BuildContext context) {
    var badgeName = insignia["nombre"];

    //print("la nueva badgeImageUrl es: $badgeImageUrl");

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth;
          return Container(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(0.5),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2),
                        ),
                        child: badgeImageUrl == 'default'
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: finalBadgeImageLocalPath == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/insignias%2Fmedalla.png?alt=media&token=e8d91863-d857-4873-9d3c-4d71b6fc0ac9',
                                            fit: BoxFit.contain),
                                      )
                                    : Image.file(finalBadgeImageLocalPath!,
                                        fit: BoxFit.cover),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: finalBadgeImageLocalPath == null
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(badgeImageUrl,
                                            fit: BoxFit.cover),
                                      )
                                    : Image.file(finalBadgeImageLocalPath!,
                                        fit: BoxFit.cover),
                              ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          //6. REMOVE BADGE IMAGE

                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: IconButton.filledTonal(
                              onPressed: () {
                                setState(() {
                                  badgeImageUrl = insignia["ImageUrl"];
                                  finalBadgeImageLocalPath = null;
                                  selectedFile = null;
                                });
                              },
                              icon: const Icon(Icons.remove_circle),
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
                                    builder: (context) {
                                      return const GaleryBadgesSelector();
                                    },
                                  ),
                                );

                                if (imageSelected != null) {
                                  setState(() {
                                    finalBadgeImageLocalPath = null;
                                    badgeImageUrl = imageSelected!;
                                  });
                                }

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
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: containerWidth / 2.5,
                    child: TextFormField(
                      onSaved: (value) async {

                          badgesImageListEmpty.add(value!);

                          if (badgeImageUrl != "default") {

                            badgesNameListEmpty.add(badgeImageUrl);  
                              
                          } else {
                            badgesNameListEmpty.add("https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/insignias%2Fmedalla.png?alt=media&token=e8d91863-d857-4873-9d3c-4d71b6fc0ac9");
                          }

                          // if (badgesImageChanged == true) {
                          //     var projectBannerTempURL = await uploadFile('insignias');

                          //     badgeImageUrl = projectBannerTempURL;

                          //     BadgesNameListEmpty.add(badgeImageUrl); 

                          //     print("El banner de las badges cambió: $badgeImageUrl");
                          // } 

                      },
                      initialValue: badgeImageUrl != "default" ? "$badgeName" : "",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                        label: Text('Insignia ${actualIndex + 1}'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
