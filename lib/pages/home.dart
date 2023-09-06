import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/projects.dart';
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
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 75, 228, 126),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2, color: Color.fromARGB(255, 6, 196, 91)),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
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
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 255, 110, 166),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2, color: Color.fromARGB(255, 196, 6, 63)),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
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
        title: Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListTile(
          tileColor: Color.fromARGB(255, 236, 245, 255),
          leading: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset('assets/logo.png'),
          ),
          title: Text(
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
        icon: Icon(Icons.add),
        label: Text('Crear proyecto'),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Portafolio dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                await _authService.signOutWithGoogle();
                setState(() {
                  _userProfile.setUser = _authService.currentUser;
                });
              },
              icon: Icon(Icons.logout),
              label: Text('Salir'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(side: BorderSide(width: 2, color: Theme.of(context).colorScheme.onSecondaryContainer), borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_userProfile.userImageUrl!),
                    ),
                    title: Text(_userProfile.userName!, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(_userProfile.userEmail!),
                    tileColor: Colors.white,
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: getProjects(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
