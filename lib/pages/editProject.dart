import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditProjectPage extends StatefulWidget {
  final String? projectID;
  final String? projectTitle;
  final String? projectDescription;
  final List? projectLabels;
  final List? projectLinks;
  final String? projectBanner;
  final Color cardColor;

  const EditProjectPage(
      {required this.projectID,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectLabels,
      required this.projectLinks,
      required this.projectBanner,
      required this.cardColor});

  @override
  State<EditProjectPage> createState() => _EditProjectPageState(
      projectID: projectID,
      projectTitle: projectTitle,
      projectDescription: projectDescription,
      projectLabels: projectLabels,
      projectLinks: projectLinks,
      projectBanner: projectBanner,
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
      required this.cardColor});

  final String? projectID;
  String? projectTitle;
  String? projectDescription;
  List? projectLabels;
  List? projectLinks;
  String? projectBanner;
  Color cardColor;

  int fieldCount = 0;
  int buttonCount = 0;

  initState() {
    super.initState();

    fieldCount = projectLabels!.length;
    buttonCount = projectLinks!.length;
  }

  @override
  Widget build(BuildContext context) {
    //10. TODO: Editar proyecto seleccionado por id
    print(projectID);

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

    ListView getFields() {

      return ListView.builder(
        shrinkWrap: true,
        itemCount: fieldCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              validator: (value) {
                print(value);
              },
              onFieldSubmitted: (value) {
                print(value);
                projectLabelsList.add(value);
              },
              initialValue: index < projectLabelsList.length
                  ? projectLabelsList[index]
                  : '',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                label: Text('Etiqueta ${index + 1} del proyecto'),
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

    ListView getButoons() {
      List projectButtonsList = projectLinks?.toList() ?? [];

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

                return Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Container(
                      width: containerWidth / 2.2,
                      child: TextFormField(
                        initialValue: index < projectButtonsList.length
                            ? projectLinks?[index]?['name']
                            : '',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text(
                              'Nombre del botón ${index + 1} del proyecto'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: containerWidth / 2.2,
                      child: TextFormField(
                        initialValue: index < projectButtonsList.length
                            ? projectLinks?[index]?['url']
                            : '',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Url del link ${index + 1} del proyecto'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    };

    //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Editor de proyectos'),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Form(
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
                          label: Text('Titulo del proyecto'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
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
                          label: Text('Descripción del proyecto'),
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
                            projectBanner = value;
                          });
                        },
                        initialValue: projectBanner,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Banner del proyecto'),
                        ),
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
                          child: FilledButton.icon(
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
                          child: FilledButton.tonalIcon(
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
                      child: Text('Botones del proyecto',
                          style: TextStyle(fontSize: 20)),
                    ),
                    getButoons(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: FilledButton.icon(
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
                          child: FilledButton.tonalIcon(
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
                      pickerColor: cardColor,
                      onColorChanged: (value) {
                        print('nuevo color: $value');
                      },
                      pickerAreaHeightPercent: 0.4,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FilledButton.tonalIcon(
                onPressed: () {
                  print('Titulo del proyecto: $projectTitle');
                  print('Descripción del proyecto: $projectDescription');
                  print('Banner del proyecto: $projectBanner');
                  print('Labels del proyecto: $projectLabelsList');
                },
                icon: Icon(Icons.send_rounded),
                label: Text('Enviar'),
              )
            ],
          ),
        ),
      )),
    );
  }
}
