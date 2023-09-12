import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery_image_selector.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_storage.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

class EditProjectPage extends StatefulWidget {
  final String projectID;
  final String? projectTitle;
  final String? projectDescription;
  final List? projectLabels;
  final List? projectLinks;
  final String? projectBanner;
  final int cardColorDecimal;
  final Color cardColor;

  const EditProjectPage(
      {required this.projectID,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectLabels,
      required this.projectLinks,
      required this.projectBanner,
      required this.cardColorDecimal,
      required this.cardColor});

  @override
  State<EditProjectPage> createState() => _EditProjectPageState(
      projectID: projectID,
      projectTitle: projectTitle,
      projectDescription: projectDescription,
      projectLabels: projectLabels,
      projectLinks: projectLinks,
      projectBanner: projectBanner,
      cardColorDecimal: cardColorDecimal,
      cardColor: cardColor);
}

class _EditProjectPageState extends State<EditProjectPage> {
  _EditProjectPageState(
      {required this.projectID,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectLabels,
      required this.projectLinks,
      required this.projectBanner,
      required this.cardColorDecimal,
      required this.cardColor});

  final String projectID;
  String? projectTitle;
  String? projectDescription;
  List? projectLabels;
  List? projectLinks;
  String? projectBanner;
  int cardColorDecimal;
  Color cardColor;

  int fieldCount = 0;
  int buttonCount = 0;

  bool mostrarPrevisualizacion = true;

  bool? bannerChanged;

  File? ImageLocalPath;

  String? imageSelected;

  initState() {
    super.initState();

    fieldCount = projectLabels!.length;
    buttonCount = projectLinks!.length;
  }

  @override
  Widget build(BuildContext context) {
    //10. TODO: Editar proyecto seleccionado por id
    //print(projectID);

    removeLabel() {
      setState(() {
        fieldCount -= 1;
      });
    }

    addLabel() {
      setState(() {
        fieldCount += 1;
      });
    }

    List projectLabelsList = projectLabels?.toList() ?? [];
    List projectLabelsListEmpty = [];

    GlobalKey<FormState> FormKey = GlobalKey<FormState>();

    ListView getFields() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: fieldCount,
        physics: NeverScrollableScrollPhysics(),
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
                  borderSide: BorderSide(color: Colors.black),
                ),
                label: Text('Etiqueta ${index + 1}'),
              ),
            ),
          );
        },
      );
    }

    removeButton() {
      setState(() {
        buttonCount -= 1;
      });
    }

    addButton() {
      setState(() {
        buttonCount += 1;
      });
    }

    List projectButtonsList = projectLinks?.toList() ?? [];

    List buttonsListFinished = [];

    List projectButtonsNameListEmpty = [];
    Map projectButtonsNameMap = {};

    List projectButtonsUrlListEmpty = [];
    Map projectButtonsUrlMap = {};

    Map mapMerged = {};

    ListView getButtons() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: buttonCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth;
                return Container(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.5),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      Container(
                        width: containerWidth / 2.2,
                        child: TextFormField(
                          onSaved: (value) {
                            projectButtonsNameListEmpty.add(value);

                            for (int i = 0;
                                i < projectButtonsNameListEmpty.length;
                                i++) {
                              projectButtonsNameMap['name'] =
                                  projectButtonsNameListEmpty[i];
                            }

                            //print('Botones del proyecto (name map) as Map: $projectButtonsNameMap');
                          },
                          initialValue: index < projectButtonsList.length
                              ? projectLinks?[index]?['name']
                              : '',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text('Nombre del botón ${index + 1}'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: containerWidth / 2.2,
                        child: TextFormField(
                          onSaved: (value) {
                            projectButtonsUrlListEmpty.add(value);

                            for (int i = 0;
                                i < projectButtonsUrlListEmpty.length;
                                i++) {
                              projectButtonsUrlMap['url'] =
                                  projectButtonsUrlListEmpty[i];
                            }

                            mapMerged = {
                              ...projectButtonsNameMap,
                              ...projectButtonsUrlMap
                            };
                            buttonsListFinished.add(mapMerged);

                            //print('Botones del proyecto (url map) as Map: $projectButtonsUrlMap');
                          },
                          initialValue: index < projectButtonsList.length
                              ? projectLinks?[index]?['url']
                              : '',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text('Url ${index + 1}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    ;

    //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editor de proyectos'),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Información principal',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          projectTitle = value;
                        });
                      },
                      initialValue: projectTitle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        label: Text('Titulo'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          projectDescription = value;
                        });
                      },
                      initialValue: projectDescription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        label: Text('Descripción'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: FormKey,
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text('Etiquetas del proyecto',
                              style: TextStyle(fontSize: 20)),
                        ),
                        getFields(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.tonalIcon(
                                onPressed: () {
                                  removeLabel();
                                },
                                icon: Icon(Icons.remove_circle),
                                label: Text('Eliminar'),
                                style: ButtonStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.icon(
                                onPressed: () {
                                  addLabel();
                                },
                                icon: Icon(Icons.add),
                                label: Text('Agregar'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Botones del proyecto',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        getButtons(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.tonalIcon(
                                onPressed: () {
                                  removeButton();
                                },
                                icon: Icon(Icons.remove_circle),
                                label: Text('Eliminar'),
                                style: ButtonStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.icon(
                                onPressed: () {
                                  addButton();
                                },
                                icon: Icon(Icons.add),
                                label: Text('Agregar'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: Text(
                      'Banner',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2),
                      ),
                      child: projectBanner == 'default'
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageLocalPath == null
                                  ? Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%2FDefault%20project%20banner.png?alt=media&token=ea4f06a6-5543-4b42-ba25-8d8fd5e2ba20',
                                      fit: BoxFit.cover)
                                  : Image.file(ImageLocalPath!,
                                      fit: BoxFit.cover))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageLocalPath == null
                                  ? Image.network(projectBanner!,
                                      fit: BoxFit.cover)
                                  : Image.file(ImageLocalPath!,
                                      fit: BoxFit.cover)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: IconButton.filledTonal(
                          onPressed: () {
                            setState(() {
                              bannerChanged = false;
                              ImageLocalPath = null;
                              selectedFile = null;
                            });
                          },
                          icon: Icon(Icons.remove_circle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: FilledButton.icon(
                          onPressed: () async {
                            selectedFile = await selectFile();

                            if (selectedFile != null) {
                              final imageLocalPath =
                                  File(selectedFile!.paths[0]!);

                              setState(() {
                                bannerChanged = true;
                                ImageLocalPath = imageLocalPath;
                              });
                            }
                          },
                          icon: Icon(Icons.file_upload_outlined),
                          label: Text('Subir'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: FilledButton.icon(
                          onPressed: () async {
                            imageSelected = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GaleryImageSelector();
                                },
                              ),
                            );
                            
                            if (imageSelected != null) {
                              setState(() {
                                ImageLocalPath == null;
                                projectBanner = imageSelected!;
                              });
                            }

                            //print(imageSelected);
                          },
                          icon: Icon(Icons.image),
                          label: Text('Galería'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Seleccionar color del proyecto',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ColorPicker(
                    hexInputBar: true,
                    pickerColor: cardColor,
                    onColorChanged: (value) {
                      if (mostrarPrevisualizacion == true) {
                        setState(() {
                          cardColor = value;
                        });
                      } else {
                        cardColor = value;
                      }

                      cardColorDecimal = value.value;
                    },
                    pickerAreaHeightPercent: 0.4,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        if (mostrarPrevisualizacion == true) {
                          setState(() {
                            mostrarPrevisualizacion = false;
                          });
                        } else {
                          setState(() {
                            mostrarPrevisualizacion = true;
                          });
                        }
                        ;
                      },
                      icon: mostrarPrevisualizacion == false
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.remove_red_eye),
                      label: mostrarPrevisualizacion == false
                          ? Text('Mostrar previsualización')
                          : Text('Ocultar previsualización'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirmar eliminación del proyecto'),
                      actions: [
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                        FilledButton(
                          onPressed: () {
                            deleteDocument(projectID);
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/');
                          },
                          child: Text('Confirmar'),
                        ),
                      ],
                    );
                  },
                );

                // Navigator.pop(context);
                // Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.delete),
              label: Text('Eliminar'),
            ),
            SizedBox(
              height: 10,
            ),
            FilledButton.icon(
              onPressed: () async {
                FormKey.currentState?.save();

                // print('Titulo del proyecto: $projectTitle');
                // print('Descripción del proyecto: $projectDescription');
                // print('Banner del proyecto: $projectBanner');
                // print('Labels del proyecto: $projectLabelsListEmpty');
                // print('Botones del proyecto (Map): $buttonsListFinished');
                // print('Color del proyecto: $cardColorDecimal');

                if (bannerChanged == true) {
                  var _projectBanner = await uploadFile();

                  setState(() {
                    projectBanner = _projectBanner;
                  });
                }

                updateDocument(
                    projectID,
                    cardColorDecimal,
                    projectBanner!,
                    projectDescription!,
                    projectLabelsListEmpty,
                    buttonsListFinished,
                    projectTitle!);
                //addDocument(projectID, cardColorDecimal, projectBanner!, projectDescription!, projectLabels!, buttonsListFinished, projectTitle!);
                //updateDocument(projectID, projectInfoList);
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.check),
              label: Text('Guardar'),
            ),
          ],
        ),
      )),
    );
  }
}
