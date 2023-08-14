import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class Paciente extends StatefulWidget {
  Paciente({Key? key}) : super(key: key);

    @override
  _Paciente createState() => _Paciente();
}

class _Paciente extends State<Paciente> {

    final nameController = TextEditingController();
    final dtnascimentoController = TextEditingController();
    final alturaController = TextEditingController();
    final alturaJoelhoController = TextEditingController();
    final compUlnaController = TextEditingController();

    //sara/dpco/obeso
    //genero
    
    DateTime _date = DateTime.now();
    TextEditingController dataNascController = TextEditingController();

    Future<Null> _selectcDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
            initialDate: _date,
        firstDate: DateTime(1990),
        lastDate: DateTime(2030),
      );
      if (picked != null && picked != _date) {
        setState(() {
          dataNascController.text = picked.toIso8601String();
        });
      }
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Nome',
              ),
            ),
            TextFormField(
              controller: dtnascimentoController,
              decoration: const InputDecoration(
                hintText: 'Data de nascimento',
              ),
            ),
            
            TextFormField(
              controller: dataNascController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 20),
                isDense: true,
                hintText: "Data de nascimento",
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.alarm),
                ),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectcDate(context);
              },
            ),
            TextFormField(
              controller: alturaController,
              decoration: const InputDecoration(
                hintText: 'Altura',
              ),
            ),
            TextFormField(
              controller: alturaJoelhoController,
              decoration: const InputDecoration(
                hintText: 'Altura do joelho',
              ),
            ),
            TextFormField(
              controller: compUlnaController,
              decoration: const InputDecoration(
                hintText: 'Comprimento da ulna',
              ),
            ),
          ],
      ), 
    ),
  );// TODO: implement build
  }
}