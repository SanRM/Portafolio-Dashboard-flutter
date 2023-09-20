import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
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
      //drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Habilidades'),
      ),
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      body: FutureBuilder(
        future: getSkillsSection(),
        builder: (context, snapshot) {

          print(snapshot.data);

          return Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.center,
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: Text(
                          'Imágen de sección',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: TextFormField(
                          onChanged: (value) {},
                          maxLines: 5,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            label: const Text('Descripción'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: Text(
                          'Descripción personal',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: TextFormField(
                          onChanged: (value) {},
                          maxLines: 5,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            label: const Text('Descripción'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
        },
       
      ),
    );
  }
}
