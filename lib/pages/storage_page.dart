import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  // final FirebaseStorage storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  final metadata = SettableMetadata(contentType: "image/jpeg");

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> upload(String path) async {
    File file = File(path);
      print('path');
      print(Text(path));
      DateTime horario =  DateTime.now(); 
      String ref = 'images/img-${horario.toString()}.jpeg';
      // String ref = 'images/img-${DateTime.now().toString()}.jpeg';
      print(horario);


      try{
        FirebaseFirestore.instance.collection("laudo").doc().set({'data': horario, 'ventilador': 'Maquet', 'imagem': ref});
        

        final uploadTask = storageRef
            .child(ref)
            .putFile(file, metadata);

        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress =
                  100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.error:
              print("errooooo");
              break;
            case TaskState.success:
              // Handle successful uploads on complete
              // ...
              break;
          }
        });

      // await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage() async{
    
    XFile? file = await getImage();
    if(file != null){
      await upload(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Storage'),
        actions: [
          IconButton(
            onPressed: pickAndUploadImage, 
            icon: const Icon(Icons.upload)),
        ],
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
