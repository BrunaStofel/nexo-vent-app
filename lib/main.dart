import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:nexo_vent_app/pages/error_page.dart';
import 'package:nexo_vent_app/pages/loading_page.dart';
import 'package:nexo_vent_app/pages/storage_page.dart';
import 'package:nexo_vent_app/pages/uploadImg.dart';

import 'package:nexo_vent_app/pages/paciente.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

  // FirebaseFirestore.instance.collection("estoque").doc().set({'produtos': 'Camisa', 'quantidade': '200'});
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NexoVent',
        home: FutureBuilder(
            future: _inicializacao,
            // future: getData(),
            builder: (context, app) {
              if (app.connectionState == ConnectionState.done) {
                // return const StoragePage();
                // return  ImageUploads();
                return Paciente();
              }

              if (app.hasError) return const ErrorPage();

              return const LoadingPage();
            })
        // home: HomePage(),
        );
  }


  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .doc("docID")
        .get();
  }
}