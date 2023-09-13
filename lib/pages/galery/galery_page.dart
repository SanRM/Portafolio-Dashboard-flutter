import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/model/image_list.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Galería'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.file_upload_outlined),
        label: const Text('Subir imágen'),
        onPressed: () async {

          selectedFile = await selectFile();

          if (selectedFile != null) {
            await uploadFile();
          }

          Navigator.pushNamed(context, '/Galery');

        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.popAndPushNamed(context, '/Galery');
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  FutureBuilder(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
