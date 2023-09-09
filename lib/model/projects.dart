import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/pages/project%20pages/editProjectPage.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

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
      // print('');
      // print('project $i: ${data?[i]}');
      // print('');
    }

    return FutureBuilder(
      future: getDocumentID(),
      builder: (context, snapshot) {
        var projectsID = snapshot.data;

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dataLength,
          //padding: EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final projectID = projectsID?[index];

            final linksCount = data?[index]['projectLinks'].length;
            final projectTitle = data?[index]['projectTitle'];
            final projectDescription = data?[index]['projectDescription'];
            final projectLabels = data?[index]['projectLabels'];
            final projectLinks = data?[index]['projectLinks'];
            final projectBanner = data?[index]['projectBanner'];
            final projectCardColorTypeInt = data?[index]['cardBgColor'];
            final projectCardColorTypeColor =
                Color(data?[index]['cardBgColor']).withOpacity(1);

            final originalCardBgColor =
                HSLColor.fromColor(projectCardColorTypeColor);
            final textColor = originalCardBgColor
                .withLightness(0.2.clamp(0.0, 1.0))
                .toColor();
            final finalCardBgColor = originalCardBgColor
                .withLightness(0.8.clamp(0.0, 1.0))
                .toColor();
            final buttonColor = originalCardBgColor
                .withLightness(0.7.clamp(0.0, 1.0))
                .toColor();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListTile(
                splashColor: Color.fromARGB(68, 255, 255, 255),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditProjectPage(
                          projectID: projectID,
                          projectTitle: projectTitle,
                          projectDescription: projectDescription,
                          projectLabels: projectLabels,
                          projectLinks: projectLinks,
                          projectBanner: projectBanner,
                          cardColorDecimal: projectCardColorTypeInt,
                          cardColor: projectCardColorTypeColor);
                    },
                  ));
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: textColor),
                    borderRadius: BorderRadius.circular(10)),
                leading: projectBanner == 'default'
                    ? Container(
                        decoration: BoxDecoration(
                            color: projectCardColorTypeColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: textColor)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/portafolio-65df7.appspot.com/o/imagenes%2FDefault%20project%20banner.png?alt=media&token=ea4f06a6-5543-4b42-ba25-8d8fd5e2ba20')))
                    : Container(
                        decoration: BoxDecoration(
                            color: projectCardColorTypeColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: textColor)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(projectBanner),
                        ),
                      ),
                title: Text(
                  projectTitle,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectDescription,
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                    Text(
                      '$projectLabels',
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: linksCount,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FilledButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(buttonColor),
                            ),
                            onPressed: () {},
                            icon: Icon(Icons.open_in_new_rounded,
                                color: textColor),
                            label: Text(
                              projectLinks[index]['name'],
                              style: TextStyle(color: textColor),
                            ));
                      },
                    )
                  ],
                ),
                tileColor: finalCardBgColor,
              ),
            );
          },
        );
      },
    );

    // return ListTile(
    //   title: Text('asd'),
    //   tileColor: Colors.cyan,
    // );
  }
}
