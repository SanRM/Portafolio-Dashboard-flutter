// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20selectors/banner_selector.dart';
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

  File? imageLocalPathFinal;

  String? imageSelected;

  @override
  initState() {
    super.initState();

    fieldCount = projectLabels!.length;
    buttonCount = projectLinks!.length;
  }

  @override
  Widget build(BuildContext context) {
    //print(projectID);

    removeLabel() {
      setState(() {
        if (fieldCount > 0) {
          fieldCount -= 1;
        }
      });
    }

    addLabel() {
      setState(() {
        fieldCount += 1;
      });
    }

    List projectLabelsList = projectLabels?.toList() ?? [];
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

    removeButton() {
      setState(() {
        if (buttonCount > 0) {
          buttonCount -= 1;
        }
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
        physics: const NeverScrollableScrollPhysics(),
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
                      SizedBox(
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
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            label: Text('Nombre del botón ${index + 1}'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
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
                                borderSide:
                                    const BorderSide(color: Colors.black)),
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

    //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor de proyectos'),
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
                            borderSide: const BorderSide(color: Colors.black)),
                        label: const Text('Titulo'),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                      maxLines: 5,
                      initialValue: projectDescription,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                        label: const Text('Descripción'),
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
              key: formKey,
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
                                icon: const Icon(Icons.remove_circle),
                                label: const Text('Eliminar'),
                                style: const ButtonStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.icon(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
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
                                icon: const Icon(Icons.remove_circle),
                                label: const Text('Eliminar'),
                                style: const ButtonStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: FilledButton.icon(
                                onPressed: () {
                                  addButton();
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Agregar'),
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
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, right: 15, left: 15),
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
                              child: imageLocalPathFinal == null
                                  ? Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%2FDefault%20project%20banner.png?alt=media&token=ea4f06a6-5543-4b42-ba25-8d8fd5e2ba20',
                                      fit: BoxFit.cover)
                                  : Image.file(imageLocalPathFinal!,
                                      fit: BoxFit.cover))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imageLocalPathFinal == null
                                  ? Image.network(projectBanner!,
                                      fit: BoxFit.cover)
                                  : Image.file(imageLocalPathFinal!,
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
                              imageLocalPathFinal = null;
                              selectedFile = null;
                            });
                          },
                          icon: const Icon(Icons.remove_circle),
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
                                imageLocalPathFinal = imageLocalPath;
                              });
                            }
                          },
                          icon: const Icon(Icons.file_upload_outlined),
                          label: const Text('Subir'),
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
                                  return const GaleryBannerSelector();
                                },
                              ),
                            );

                            if (imageSelected != null) {
                              setState(() {
                                imageLocalPathFinal == null;
                                projectBanner = imageSelected!;
                              });
                            }

                            //print(imageSelected);
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Galería'),
                        ),
                      ),
                    ],
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
                  const Padding(
                    padding: EdgeInsets.all(15),
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
                      },
                      icon: mostrarPrevisualizacion == false
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye),
                      label: mostrarPrevisualizacion == false
                          ? const Text('Mostrar previsualización')
                          : const Text('Ocultar previsualización'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirmar eliminación del proyecto: $projectTitle'),
                      actions: [
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar'),
                        ),
                        FilledButton(
                          onPressed: () {
                            deleteDocument(projectID, 'Lista de proyectos');
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/');
                          },
                          child: const Text('Confirmar'),
                        ),
                      ],
                    );
                  },
                );

                // Navigator.pop(context);
                // Navigator.popAndPushNamed(context, '/');
              },
              icon: const Icon(Icons.delete),
              label: const Text('Eliminar'),
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton.icon(
              onPressed: () async {
                formKey.currentState?.save();

                // print('Titulo del proyecto: $projectTitle');
                // print('Descripción del proyecto: $projectDescription');
                // print('Banner del proyecto: $projectBanner');
                // print('Labels del proyecto: $projectLabelsListEmpty');
                // print('Botones del proyecto (Map): $buttonsListFinished');
                // print('Color del proyecto: $cardColorDecimal');

                if (bannerChanged == true) {
                  var projectBannerTemp = await uploadFile('imagenes');

                  setState(() {
                    projectBanner = projectBannerTemp;
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
              icon: const Icon(Icons.check),
              label: const Text('Guardar'),
            ),
          ],
        ),
      )),
    );
  }
}
