// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/firebase_user.dart';
import 'package:portafolio_dashboard_flutter/services/auth_with_google.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

class EditCertificate extends StatefulWidget {

  final String certificateId;  
  final String certificateTitle;
  final String certificateDescription; 
  final List certificateLabels; 
  final String certificateUrl;

  const EditCertificate({super.key, required this.certificateId, required this.certificateTitle, required this.certificateDescription, required this.certificateLabels, required this.certificateUrl});

  @override
  State<EditCertificate> createState() => _EditCertificateState(certificateID: certificateId, certificateTitle: certificateTitle, certificateDescription: certificateDescription, certificateLabels: certificateLabels, certificateUrl: certificateUrl);
}

class _EditCertificateState extends State<EditCertificate> {

  String certificateID;
  String certificateTitle;
  String certificateDescription; 
  List certificateLabels; 
  String certificateUrl;

  _EditCertificateState({required this.certificateID, required this.certificateTitle, required this.certificateDescription, required this.certificateLabels, required this.certificateUrl});

  final FirebaseUserProfile _userProfile = FirebaseUserProfile();
  final GoogleAuthService _authService = GoogleAuthService();

  @override
  void initState() {
    super.initState();
    _userProfile.setUser = _authService.currentUser;
    fieldCount = certificateLabels.length;
  }

  int fieldCount = 0;


  @override
  Widget build(BuildContext context) {

    List projectLabelsList = certificateLabels.toList();
    List projectLabelsListEmpty = [];

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              initialValue: index < projectLabelsList.length
              ? projectLabelsList[index]
              : '',
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar certificado'),
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
                        initialValue: certificateTitle,
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
                        initialValue: certificateDescription,
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
                        initialValue: certificateUrl,
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

                  print(certificateID);
                  print('certificateTitle: $certificateTitle');
                  print('certificateDescription: $certificateDescription');
                  print('certificateUrl: $certificateUrl');
                  print('projectLabelsListEmpty: $projectLabelsListEmpty');

                  updateCertificate(certificateID, certificateTitle, certificateDescription, certificateUrl, projectLabelsListEmpty);

                  //projectLabelsListEmpty = [];
                  Navigator.pop(context);
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
