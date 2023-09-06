import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portafolio_dashboard_flutter/pages/Home.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 190, 247, 255)
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
