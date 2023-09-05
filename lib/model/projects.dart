import 'package:flutter/material.dart';

class PortafolioProjects extends StatefulWidget {
  PortafolioProjects({super.key, required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  @override
  State<PortafolioProjects> createState() =>
      _PortafolioProjectsState(snapshot: snapshot);
}

class _PortafolioProjectsState extends State<PortafolioProjects> {
  _PortafolioProjectsState({required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  @override
  Widget build(BuildContext context) {
    var data = snapshot?.data;
    var dataLength = data?.length;

    for (var i = 0; i < dataLength!; i++) {
      print('');
      print('project $i: ${data?[i]}');
      print('');
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataLength,
      //padding: EdgeInsets.all(20),
      itemBuilder: (context, index) {
        Color cardColor = Color(data?[index]['cardBgColor']).withOpacity(1);

        final originalCardBgColor = HSLColor.fromColor(cardColor);
        final finalCardBgColor =
            originalCardBgColor.withLightness(0.2.clamp(0.0, 1.0)).toColor();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            splashColor: cardColor,
            onTap: () {
              editProjectInformation();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: data?[index]['projectBanner'] == 'default'
                ? Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%2FDefault%20project%20banner.png?alt=media&token=ea4f06a6-5543-4b42-ba25-8d8fd5e2ba20')
                : Image.network('${data?[index]['projectBanner']}'),
            title: Text(
              '${data?[index]['projectTitle']}',
              style: TextStyle(
                  color: finalCardBgColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data?[index]['projectDescription']}'),
                Text('${data?[index]['projectLabels']}')
              ],
            ),
            tileColor: cardColor,
          ),
        );
      },
    );

    // return ListTile(
    //   title: Text('asd'),
    //   tileColor: Colors.cyan,
    // );
  }

  void editProjectInformation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editor de proyectos'),
          content: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar titulo del proyecto')),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar descripción del proyecto')),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar banner del proyecto')),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar etiquetas del proyecto')),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar links del proyecto')),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text('Cambiar color del proyecto')),
              ),
            ],
          )),
        );
      },
    );
  }
}
