import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/pages/projects/addproject.dart';
import 'package:portafolio_dashboard_flutter/pages/projects/project_list.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  void _showApprovedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        backgroundColor: const Color.fromARGB(255, 75, 228, 126),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
              width: 2, color: Color.fromARGB(255, 6, 196, 91)),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                '¡Sesión iniciada correctamente!',
                style: TextStyle(
                  //color: primaryBlack,
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRejectedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        backgroundColor: const Color.fromARGB(255, 255, 110, 166),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
              width: 2, color: Color.fromARGB(255, 196, 6, 63)),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                '¡No se pudo iniciar la sesión!',
                style: TextStyle(
                  fontSize: 20,
                  //color: primaryBlack,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return _userProfile.userId == null
        ? _buildLoginScreen()
        : _buildLoggedInScreen();
  }

  _buildLoginScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListTile(
          tileColor: const Color.fromARGB(255, 236, 245, 255),
          leading: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset('assets/logo.png'),
          ),
          title: const Text(
            'Google sign in',
            style: TextStyle(color: Color.fromARGB(255, 0, 51, 114)),
          ),
          onTap: () async {
            final login = await _authService.signInWithGoogle();
            setState(() {
              _userProfile.setUser = _authService.currentUser;
            });
            if (login != null) {
              return _showApprovedSnackBar();
            } else {
              return _showRejectedSnackBar();
            }
          },
        ),
      ),
    );
  }

  _buildLoggedInScreen() {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Crear proyecto'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddProjectPage();
            },
          ));
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_userProfile.userName!),
              accountEmail: Text(_userProfile.userEmail!),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(_userProfile.userImageUrl!),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Información inicial'),
                  onTap: () {
                    // Agrega aquí la lógica de navegación o acción para la opción "Inicio".
                    Navigator.pop(context); // Cierra el cajón lateral.
                    Navigator.pushNamed(context, '/InitialInformation');
                  },
                ),
                
                ListTile(
                  leading: const Icon(Icons.edit_note_sharp),
                  title: const Text('Editor de proyectos'),
                  onTap: () {
                    // Agrega aquí la lógica de navegación o acción para la opción "Inicio".
                    Navigator.pop(context); // Cierra el cajón lateral.
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_sharp),
                  title: const Text('Habilidades'),
                  onTap: () {
                    // Agrega aquí la lógica de navegación o acción para la opción "Configuración".
                    //Navigator.pop(context); // Cierra el cajón lateral.
                    Navigator.pushNamed(context, '/Skills');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Galeria'),
                  onTap: () {
                    // Agrega aquí la lógica de navegación o acción para la opción "Configuración".
                    //Navigator.pop(context); // Cierra el cajón lateral.
                    Navigator.pushNamed(context, '/Galery');
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: FilledButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await _authService.signOutWithGoogle();
                  setState(() {
                    _userProfile.setUser = _authService.currentUser;
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ),
            // Agrega más elementos de lista según tus necesidades.
          ],
        ),
      ),
      // El c
      appBar: AppBar(
        title: const Text('Lista de proyectos'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.popAndPushNamed(context, '/');
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  FutureBuilder(
                    future: getProjects(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //print(snapshot.data);
                        return PortafolioProjects(snapshot: snapshot);
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
