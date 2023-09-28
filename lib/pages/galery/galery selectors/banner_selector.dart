import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';

class GaleryBannerSelector extends StatefulWidget {
  const GaleryBannerSelector({super.key});

  @override
  State<GaleryBannerSelector> createState() => _GaleryBannerSelectorState();
}

class _GaleryBannerSelectorState extends State<GaleryBannerSelector> {
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
        title: const Text('Seleccionar imágen'),
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
                  FutureBuilder(
                    future: getUrlImageList('imagenes'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PortafolioImagesSelector extends StatefulWidget {
  const PortafolioImagesSelector({super.key, required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  @override
  State<PortafolioImagesSelector> createState() =>
      _PortafolioImagesSelectorState(snapshot: snapshot);
}

class _PortafolioImagesSelectorState extends State<PortafolioImagesSelector> {
  _PortafolioImagesSelectorState({required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  bool toggleChild = false;

  @override
  Widget build(BuildContext context) {
    var data = snapshot?.data;
    var dataLength = data?.length;

    List<Widget> images = [];

    for (var i = 0; i < dataLength!; i++) {
      String imageSelected = data?[i];

      images.add(LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 1),
            crossFadeState: toggleChild
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: GestureDetector(
              onTap: () async {
                setState(() {
                  toggleChild = !toggleChild;
                });
                Future.delayed(const Duration(milliseconds: 250), () {
                  Navigator.pop(context, imageSelected);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageSelected,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            secondChild: GestureDetector(
              onTap: () {
                setState(() {
                  toggleChild = !toggleChild;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageSelected,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ));
    }

    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: images,
    );
  }
}
