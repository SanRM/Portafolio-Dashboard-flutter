import 'package:flutter/material.dart';

class ImageManagerSelector extends StatefulWidget {
  final String imageSelected;

  const ImageManagerSelector(
      {super.key, required this.imageSelected});

  @override
  State<ImageManagerSelector> createState() => _ImageManagerSelectorState(
      imageSelected: imageSelected);
}

class _ImageManagerSelectorState extends State<ImageManagerSelector> {
  final String imageSelected;

  _ImageManagerSelectorState(
      {required this.imageSelected});

  bool toggleChild = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 1),
          crossFadeState: toggleChild
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: GestureDetector(
            onTap: () async {
              setState(() {
                toggleChild = !toggleChild;
              });
              Future.delayed(const Duration(milliseconds: 250),(){
                Navigator.pop(context, imageSelected);
              });

            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageSelected,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              setState(() {
                toggleChild = !toggleChild;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)),
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageSelected,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
