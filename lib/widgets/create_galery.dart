import 'package:flutter/material.dart';

class CreateGalery extends StatefulWidget {
  final String galeryName;
  final VoidCallback buttonFunction;
  final String buttonName;
  final Widget widgetToLoad;

  const CreateGalery(
      {super.key,
      required this.galeryName,
      required this.buttonFunction,
      required this.buttonName,
      required this.widgetToLoad});

  @override
  State<CreateGalery> createState() => _CreateGaleryState(
      galeryName: galeryName,
      buttonFunction: buttonFunction,
      buttonName: buttonName,
      widgetToLoad: widgetToLoad);
}

class _CreateGaleryState extends State<CreateGalery> {
  String galeryName;
  VoidCallback buttonFunction;
  String buttonName;
  Widget widgetToLoad;

  _CreateGaleryState(
      {required this.galeryName,
      required this.buttonFunction,
      required this.buttonName,
      required this.widgetToLoad});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    galeryName,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                FilledButton.icon(
                  onPressed: buttonFunction,
                  icon: Icon(Icons.file_upload_outlined),
                  label: Text(buttonName),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          widgetToLoad,
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
