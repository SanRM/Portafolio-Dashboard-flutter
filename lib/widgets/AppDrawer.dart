import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/Home.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery_page.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({required this.userProfile, required this.authService});

  final FirebaseUserProfile userProfile;
  final GoogleAuthService authService;

  @override
  State<AppDrawer> createState() =>
      _AppDrawerState(userProfile: userProfile, authService: authService);
}

class _AppDrawerState extends State<AppDrawer> {
  _AppDrawerState({required this.userProfile, required this.authService});

  final FirebaseUserProfile userProfile;
  final GoogleAuthService authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(widget.userProfile.userName!),
              accountEmail: Text(widget.userProfile.userEmail!),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(widget.userProfile.userImageUrl!),
              )),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.edit_note_sharp),
                title: Text('Editor de proyectos'),
                onTap: () {
                  // Agrega aquí la lógica de navegación o acción para la opción "Inicio".
                  //Navigator.pop(context); // Cierra el cajón lateral.
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Galería'),
                onTap: () {
                  // Agrega aquí la lógica de navegación o acción para la opción "Configuración".
                  //Navigator.pop(context); // Cierra el cajón lateral.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GaleryPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: FilledButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await widget.authService.signOutWithGoogle();
                setState(() {
                  userProfile.setUser = authService.currentUser;
                });
              },
              icon: Icon(Icons.logout),
              label: Text('Cerrar sesión'),
            ),
          ),
          // Agrega más elementos de lista según tus necesidades.
        ],
      ),
    );
  }
}
