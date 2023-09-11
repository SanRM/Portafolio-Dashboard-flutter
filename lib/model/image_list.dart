import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/model/image_utilities.dart';

class PortafolioImages extends StatefulWidget {
  PortafolioImages({super.key, required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  @override
  State<PortafolioImages> createState() =>
      _PortafolioImagesState(snapshot: snapshot);
}

class _PortafolioImagesState extends State<PortafolioImages> {
  _PortafolioImagesState({required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    var data = snapshot?.data;
    var dataLength = data?.length;

    List<Widget> images = [];

    for (var i = 0; i < dataLength!; i++) {
      images.add(
        ImageManager(imageSelected: data?[i], indexSelected: i),
      );
    }

    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: images,
    );
  }
}
