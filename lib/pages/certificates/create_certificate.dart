// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

class CreateCertificate extends StatefulWidget {
  const CreateCertificate({super.key});

  @override
  State<CreateCertificate> createState() => _CreateCertificateState();
}

class _CreateCertificateState extends State<CreateCertificate> {
  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? certificateTitle;
  String? certificateDescription;
  String? certificateUrl;
  List projectLabelsListEmpty = [];

  int fieldCount = 0;

  ListView getFields() {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: fieldCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            onSaved: (value) {
              setState(() {
                projectLabelsListEmpty.add(value);
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
              label: Text('Etiqueta ${index + 1}'),
            ),
          ),
        );
      },
    );
  }

  removeLabel() {
    setState(() {
      if (fieldCount > 0) {
        fieldCount -= 1;
        projectLabelsListEmpty = [];
      }
    });
  }

  addLabel() {
    setState(() {
      fieldCount += 1;
      projectLabelsListEmpty = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear certificado'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          alignment: Alignment.center,
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Información del certificado',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            certificateTitle = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          label: const Text('Titulo'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            certificateDescription = value;
                          });
                        },
                        maxLines: 5,
                        //initialValue: projectDescription,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            certificateUrl = value;
                          });
                        },
                        //initialValue: projectDescription,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          label: const Text('Url'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Etiquetas del certificado',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            height: fieldCount > 0 ? 0 : 20,
                          ),
                          getFields(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.icon(
                                  onPressed: () {
                                    removeLabel();
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                  label: const Text('Eliminar'),
                                  style: const ButtonStyle(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: FilledButton.tonalIcon(
                                  onPressed: () {
                                    addLabel();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text('Agregar'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton.tonalIcon(
                onPressed: () async {
                  formKey.currentState?.save();

                  //print('certificateTitle: $certificateTitle');
                  //print('certificateDescription: $certificateDescription');
                  //print('certificateUrl: $certificateUrl');
                  //print('projectLabelsListEmpty: $projectLabelsListEmpty');

                  addCertificate(
                      certificateTitle!,
                      certificateDescription!,
                      certificateUrl!,
                      projectLabelsListEmpty);

                  projectLabelsListEmpty = [];
                  Navigator.popAndPushNamed(context, '/Certificados');
                },
                icon: const Icon(Icons.check),
                label: const Text('Guardar'),
              ),
            ],
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
