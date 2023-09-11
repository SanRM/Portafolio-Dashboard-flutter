import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/model/image_list_selector.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';

class GaleryImageSelector extends StatefulWidget {
  const GaleryImageSelector({super.key});

  @override
  State<GaleryImageSelector> createState() => _GaleryImageSelectorState();
}

class _GaleryImageSelectorState extends State<GaleryImageSelector> {
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
      appBar: AppBar(
        title: Text('Seleccionar imágen'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.popAndPushNamed(context, '/');
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: FutureBuilder(
                      future: getAllImageUrls(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //print(snapshot.data);
                          return PortafolioImagesSelector(snapshot: snapshot);
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
      ),
    );
  }
}
