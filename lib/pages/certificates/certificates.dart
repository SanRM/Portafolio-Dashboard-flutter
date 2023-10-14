import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/pages/certificates/create_certificate.dart';
import 'package:portafolio_dashboard_flutter/pages/certificates/edit_certificate.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';
import 'package:portafolio_dashboard_flutter/widgets/app_drawer.dart';

class Certificates extends StatefulWidget {
  const Certificates({super.key});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  List certificadosID = [];
  List certificadosIDList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Crear certificado'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const CreateCertificate();
            },
          ));
        },
      ),
      drawer: AppDrawer(userProfile: _userProfile, authService: _authService),
      appBar: AppBar(
        title: const Text('Lista de certificados'),
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
                    future: getCollectionInfo("Certificados"),
                    builder: (context, snapshot) {
                      List<dynamic>? certificates = snapshot.data;

                      if (snapshot.hasData) {

                        return FutureBuilder(
                          future: getDocumentID("Certificados"),
                          builder: (context, snapshot) {

                            if (snapshot.hasData) {

                              List<dynamic>? certificatesID = snapshot.data;

                              //print("Certificados id: $certificatesID");

                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: certificates?.length,
                                //padding: EdgeInsets.all(20),
                                itemBuilder: (context, index) {

                                  final String certificateId = certificatesID?[index];
                                  final String certificateTitle = certificates?[index]['title'];
                                  final String certificateDescription = certificates?[index]['description'];
                                  final List certificateLabels = certificates?[index]['labels'];
                                  final String certificateUrl = certificates?[index]['Url'];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: ListTile(
                                        splashColor: const Color.fromARGB(68, 255, 255, 255),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return EditCertificate(
                                                  certificateId: certificateId,
                                                  certificateTitle: certificateTitle,
                                                  certificateDescription: certificateDescription,
                                                  certificateLabels: certificateLabels,
                                                  certificateUrl: certificateUrl);
                                            },
                                          ),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 2, 
                                            color: Colors.black
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                          ),
                                      title: Text(
                                        certificateTitle,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            certificateDescription,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: certificateLabels.length,
                                              itemBuilder: (context, index) {
                                                return Wrap(
                                                  children: [
                                                    Chip(
                                                      label: Text(certificateLabels[index]),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            certificateUrl,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      tileColor: Colors.white,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Color.fromARGB(137, 0, 141, 151),
                                ),
                              );
                            }
                          },
                        );
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

    // return ListTile(
    //   title: Text('asd'),
    //   tileColor: Colors.cyan,
    // );
  }
}
