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

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  int selectedIndex = 0;

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
        },
        selectedFontSize: 15,
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
            label: 'Personal',
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
                CreateGalery(
                  galeryName: 'Banners',
                  buttonName: 'Subir banner',
                  buttonFunction: () async {
                    selectedFile = await selectFile();

                    if (selectedFile != null) {
                      await uploadFile();
                    }

                    Navigator.pushNamed(context, '/Galery');
                  },
                  widgetToLoad: FutureBuilder(
                    future: getAllImageUrls(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //print(snapshot.data);
                        return PortafolioImages(snapshot: snapshot);
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

                const SizedBox(
                  height: 20,
                ),

                //2. Personal images
                
                CreateGalery(
                  galeryName: 'Imágenes personales',
                  buttonName: 'Subir foto',
                  buttonFunction: () async {
                    selectedFile = await selectFile();

                    if (selectedFile != null) {
                      await uploadFile();
                    }

                    Navigator.pushNamed(context, '/Galery');
                  },
                  widgetToLoad: FutureBuilder(
                    future: getAllImageUrls(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //print(snapshot.data);
                        return Container();
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
