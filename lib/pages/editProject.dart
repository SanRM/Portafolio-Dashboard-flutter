import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditProjectPage extends StatefulWidget {
  final int? index;
  final String? projectTitle;
  final String? projectDescription;
  final List? projectLabels;
  final List? projectLinks;
  final String? projectBanner;
  final Color cardColor;

  const EditProjectPage(
      {required this.index,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectLabels,
      required this.projectLinks,
      required this.projectBanner,
      required this.cardColor});

  @override
  State<EditProjectPage> createState() => _EditProjectPageState(
      index: index,
      projectTitle: projectTitle,
      projectDescription: projectDescription,
      projectLabels: projectLabels,
      projectLinks: projectLinks,
      projectBanner: projectBanner,
      cardColor: cardColor);
}

class _EditProjectPageState extends State<EditProjectPage> {
  _EditProjectPageState(
      {required this.index,
      required this.projectTitle,
      required this.projectDescription,
      required this.projectLabels,
      required this.projectLinks,
      required this.projectBanner,
      required this.cardColor});

  final int? index;
  final String? projectTitle;
  final String? projectDescription;
  final List? projectLabels;
  final List? projectLinks;
  final String? projectBanner;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 20,
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Etiquetas del proyecto',
                          style: TextStyle(fontSize: 20)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: projectLabels?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            initialValue: projectLabels?[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black)),
                              label: Text('Etiqueta ${index + 1} del proyecto'),
                              //icon: Icon(Icons.abc_outlined),
                              icon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('Nueva etiqueta'),
                      ),
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
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Botones del proyecto',
                          style: TextStyle(fontSize: 20)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: projectLinks?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: projectLinks?[index]['name'],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    label: Text(
                                        'Nombre del botón ${index + 1} del proyecto'),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  initialValue: projectLinks?[index]['url'],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    label: Text(
                                        'Url del link ${index + 1} del proyecto'),
                                  ),
                                ),
                              ],
                            ));
                      },
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
                onPressed: () {},
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
