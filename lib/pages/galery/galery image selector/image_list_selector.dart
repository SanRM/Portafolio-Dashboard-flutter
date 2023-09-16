import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/pages/galery/galery%20image%20selector/image_utilities_selector.dart';

class PortafolioImagesSelector extends StatefulWidget {
  const PortafolioImagesSelector({super.key, required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  @override
  State<PortafolioImagesSelector> createState() =>
      _PortafolioImagesSelectorState(snapshot: snapshot);
}

class _PortafolioImagesSelectorState extends State<PortafolioImagesSelector> {
  _PortafolioImagesSelectorState({required this.snapshot});

  final AsyncSnapshot<List>? snapshot;

  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    var data = snapshot?.data;
    var dataLength = data?.length;

    List<Widget> images = [];

    for (var i = 0; i < dataLength!; i++) {
      images.add(
        ImageManagerSelector(imageSelected: data?[i]),
      );
    }

    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: images,
    );
  }
}
