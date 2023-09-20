import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20page/image_utilities.dart';

class PortafolioImages extends StatefulWidget {

  final AsyncSnapshot<List>? snapshot;
  final String galeryType;

  const PortafolioImages({super.key, required this.snapshot, required this.galeryType});

  @override
  State<PortafolioImages> createState() => _PortafolioImagesState(snapshot: snapshot, galeryType: galeryType);
}

class _PortafolioImagesState extends State<PortafolioImages> {
  _PortafolioImagesState({required this.snapshot, required this.galeryType});

  final AsyncSnapshot<List>? snapshot;
  final String galeryType;

  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    
    var data = snapshot?.data;
    var dataLength = data?.length;

    List<Widget> images = [];

    for (var i = 0; i < dataLength!; i++) {
      images.add(
        ImageManager(imageSelected: data?[i], indexSelected: i, galeryType: galeryType),
      );
    }

    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: images,
    );
  }
  
}
