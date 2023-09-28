import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20page/image_list.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';
import 'package:portafolio_dashboard_flutter/widgets/create_galery.dart';

class GaleryPage extends StatefulWidget {
  const GaleryPage({super.key});

  @override
  State<GaleryPage> createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  scrollTo(widget) {
    Scrollable.ensureVisible(widget.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
  }

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  int selectedIndex = 0;

  GlobalKey bannersKey = GlobalKey();
  GlobalKey personalImagesKey = GlobalKey();
  GlobalKey badgesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Galería'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });

          switch (selectedIndex) {
            case 0:
              scrollTo(bannersKey);
              break;
            case 1:
              scrollTo(personalImagesKey);
              break;
            case 2:
              scrollTo(badgesKey);
              break;
          }
        },
        selectedFontSize: 15,
        iconSize: 30,
        currentIndex: selectedIndex,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.branding_watermark_rounded),
            label: 'Banners',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Fotos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rate_rounded),
            label: 'Insignias',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.popAndPushNamed(context, '/Galery');
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //2. Banners
                Container(
                  key: bannersKey,
                  child: CreateGalery(
                    galeryName: 'Banners',
                    buttonName: 'Subir banner',
                    buttonFunction: () async {
                      selectedFile = await selectFile();

                      if (selectedFile != null) {
                        await uploadFile('imagenes');
                      }

                      Navigator.pushNamed(context, '/Galery');
                    },
                    widgetToLoad: FutureBuilder(
                      future: getUrlImageList('imagenes'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //print(snapshot.data);
                          return PortafolioImages(
                              snapshot: snapshot, galeryType: 'imagenes');
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Color.fromARGB(137, 0, 141, 151),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //2. Personal images

                Container(
                  key: personalImagesKey,
                  child: CreateGalery(
                    galeryName: 'Imágenes personales',
                    buttonName: 'Subir imágen',
                    buttonFunction: () async {
                      selectedFile = await selectFile();

                      if (selectedFile != null) {
                        await uploadFile('imagenes personales');
                      }

                      Navigator.pushNamed(context, '/Galery');
                    },
                    widgetToLoad: FutureBuilder(
                      future: getAllPersonalImagesUrls(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //print(snapshot.data);
                          return PortafolioImages(
                              snapshot: snapshot,
                              galeryType: 'imagenes personales');
                          //return Container();
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Color.fromARGB(137, 0, 141, 151),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //2. Insignias

                Container(
                  key: badgesKey,
                  child: CreateGalery(
                    galeryName: 'Insignias',
                    buttonName: 'Subir insignia',
                    buttonFunction: () async {
                      selectedFile = await selectFile();

                      if (selectedFile != null) {
                        await uploadFile('insignias');
                      }

                      Navigator.pushNamed(context, '/Galery');
                    },
                    widgetToLoad: FutureBuilder(
                      future: getAllLabelsUrls(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //print(snapshot.data);
                          return PortafolioImages(
                              snapshot: snapshot, galeryType: 'insignias');
                          //return Container();
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Color.fromARGB(137, 0, 141, 151),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
