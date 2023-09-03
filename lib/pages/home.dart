import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/services/auth_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double backgroundWidth = constraints.maxWidth;
            double backgroundHeight = constraints.maxHeight;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //color: const Color.fromARGB(255, 167, 167, 167),
                    width: backgroundWidth,
                    height: backgroundHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {

                            print(signInWithGoogle());
                            
                          },
                          icon: Icon(Icons.ac_unit_outlined),
                        ),
                       
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
