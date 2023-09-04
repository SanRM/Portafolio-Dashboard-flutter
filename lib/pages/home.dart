import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
//import 'package:portafolio_dashboard_flutter/pages/home_google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user.user = _auth.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          //backgroundColor: Colors.red,
        ),
        body: _user.uid == null ? _login() : _logged()

        //
        );
  }

  ListView _login() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: ListTile(
            tileColor: Color.fromARGB(255, 218, 234, 253),
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            title: Text('Google sign in'),
            onTap: () async {
              await _auth.signInGoogle();
              setState(
                () {
                  _user.user = _auth.user;
                },
              );
            },
          ),
        )
      ],
    );
  }

  _logged() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_user.imageUrl!),
          ),
          Text(_user.name!),
          Text(_user.email!),
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOutGoogle();
              setState(
                () {
                  _user.user = _auth.user;
                },
              );
            },
            icon: Icon(Icons.logout),
            label: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
