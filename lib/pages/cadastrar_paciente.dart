import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class CadastrarPaciente extends StatefulWidget {
  CadastrarPaciente({Key? key}) : super(key: key);

    @override
  _CadastrarPaciente createState() => _CadastrarPaciente();
}

class _CadastrarPaciente extends State<CadastrarPaciente> {
    final nameController = TextEditingController();
    final dtnascimentoController = TextEditingController();
    final alturaController = TextEditingController();
    final alturaJoelhoController = TextEditingController();
    final compUlnaController = TextEditingController();
    
    int selectedGender = 0;

    List<Map<String, dynamic>> data = [
      {
        'title': 'SDRA',
        'value': false,
      },
      {
        'title': 'DPCO',
        'value': false,
      },
      {
        'title': 'Obeso',
        'value': false,
      },
      {
        'title': 'Neurocrítico',
        'value': false,
      },
      {
        'title': 'Nenhum',
        'value': true,
      },
    ];
    
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
      appBar: AppBar(
        title: const Text('Cadastrar paciente'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          width: double.infinity,
          child: 
          Column(
            children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Nome',
              ),
            ),
            Row(
              children:[
                Expanded(
                  child:
                  ListTile(
                    title: const Text('Feminino'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(child: 
                ListTile(
                    title: const Text('Maculino'),
                    leading: Radio(
                      value: 2,
                      groupValue: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                )
              ],
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
          Expanded(
            flex: 6,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index){
                return CheckboxListTile(
                  title: Text(data[index]['title'].toString()),
                  value: data[index]['value'],
                  onChanged: (value){
                    setState(() {
                      data[index]['value'] = value!;
                    });
                  });
              },
            ),
          ),
          Text('Escolha uma das opções abaixo para inserir altura do paciente', textAlign: TextAlign.left),

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

          ElevatedButton(onPressed: () {
            // CollectionReference 
          },
          child: const Text('Salvar'),
          )
        ],      
      ),
      ), 
    ),
  );// TODO: implement build
  }
}