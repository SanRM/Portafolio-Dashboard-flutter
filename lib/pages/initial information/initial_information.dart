import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20selectors/personal_images_selector.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

bool badgesImageChanged = false;

class InitialInformation extends StatefulWidget {
  const InitialInformation({super.key});

  @override
  State<InitialInformation> createState() => _InitialInformationState();
}

class _InitialInformationState extends State<InitialInformation> {
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
  String principalBanner = "https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%20personales%2FPrincipaImage.png?alt=media&token=5b25de8b-1769-4428-857b-b9281eb8f9c4";
  bool imageChanged = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Información inicial'),
      ),
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      body: FutureBuilder(
        future: getInitialInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data);

            if (imageChanged == false) {
              principalBanner = snapshot.data?[0]['principalBanner'];
            }

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
                                'Imágen principal',
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
                                            ? Image.network(principalBanner,
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
                                        principalBanner = snapshot.data?[0]['principalBanner'];
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
                                        final imageLocalPath = File(selectedFile!.paths[0]!);
                
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
                                          principalBanner = imageSelected!;
                                        });
                                      }
                
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
                      FilledButton.icon(
                        onPressed: () async {
                
                          formKey.currentState?.save();

                          if (bannerChanged == true) {
                            var projectBannerTemp = await uploadFile('imagenes personales');

                            setState(() {
                              principalBanner = projectBannerTemp;
                            });
                          }

                          var documentID = await getInitialInfoID();

                          updatePrincipalImage(documentID[0], principalBanner);

                          Navigator.popAndPushNamed(context, '/InitialInformation');
                          
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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

