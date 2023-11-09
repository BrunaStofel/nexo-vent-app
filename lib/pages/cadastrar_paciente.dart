import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';


class CadastrarPaciente extends StatefulWidget {
  CadastrarPaciente({Key? key}) : super(key: key);

    @override
  _CadastrarPaciente createState() => _CadastrarPaciente();
}

List<String> list = <String>['18.5', '19.0', '19.5', '20.0', ];

class _CadastrarPaciente extends State<CadastrarPaciente> {
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;

    final nameController = TextEditingController();
    final dtnascimentoController = TextEditingController();
    final alturaController = TextEditingController();
    final alturaJoelhoController = TextEditingController();
    final compUlnaController = TextEditingController();
    
    int selectedGender = 0;

    final dropValue = ValueNotifier('');
    final List<dynamic> dropOpcoes = ['Altura total', 'Altura do joelho', 'Altura da ulna'];

    List<Map<String, dynamic>> condicoes = [
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
        firstDate: DateTime(1900),
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
          Expanded(
            flex: 1,
            child: Column(
              children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Nome',
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
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
              ),    
              Expanded(
                flex: 1,
                child: TextFormField(
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
              ),

            Expanded(child: 
              Text('Condição:', 
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: condicoes.length,
                itemBuilder: (context, index){
                  return CheckboxListTile(
                    title: Text(condicoes[index]['title'].toString()),
                    value: condicoes[index]['value'],
                    onChanged: (value){
                      setState(() {
                        condicoes[index]['value'] = value!;
                      });
                    });
                },
              ),
            ),          
          
            Expanded(
              flex: 1,
              child: ValueListenableBuilder(valueListenable: dropValue, 
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  isExpanded: true,
                  icon: const Icon(Icons.height),
                  hint: const Text('Tipo de altura do paciente'),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (escolha) => dropValue.value = escolha.toString(),
                  items: dropOpcoes.map((op) => DropdownMenuItem<String>( 
                      value: op,
                      child: Text(op),
                      ))
                    .toList(),
                  );
              }),
            ),          
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: alturaController,
                decoration: const InputDecoration(
                  hintText: 'Insira a altura (CM)',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(onPressed: () {
                double altura = 0;
                double alturaInserida = double.parse(alturaController.text); 
                String genero = '';
                //calcular idade
                DateTime hoje = DateTime.now();
                DateTime data = DateTime.parse(dataNascController.text);
                Duration diferenca = hoje.difference(data);
                int idade = (diferenca.inDays / 365).floor();
                print("Idade: $idade anos");

                if (dropValue.value == 'Altura do joelho') {
                  print('Altura do joelho');
                  if(selectedGender ==1){
                    //mulher
                    altura = (84.88 - (0.24 * idade) + (1.83 * alturaInserida));
                  } else{
                    //homem
                    altura = (64.19 - (0.04 * idade) + (2.02 * alturaInserida));
                  }
                  print('altura: $altura cm');

                } else if (dropValue.value == 'Altura da ulna'){
                  print('Altura da ulna');
                  if(idade >= 65){
                    if(selectedGender == 1){
                      //mulher
                      if (alturaInserida >=1 && alturaInserida <= 18.7){
                        altura = 140;
                      }
                      if (alturaInserida >=18.8 && alturaInserida <= 19.2){
                        altura = 142;
                      }
                      if (alturaInserida >=19.3 && alturaInserida <= 19.7){
                        altura = 144;
                      }
                      if (alturaInserida >=19.8 && alturaInserida <= 20.2){
                        altura = 145;
                      }
                      if (alturaInserida >=20.3 && alturaInserida <=20.7){
                        altura = 147;
                      }
                      if (alturaInserida >=20.8 && alturaInserida <= 21.2){
                        altura = 148;
                      }
                      if (alturaInserida >=21.3 && alturaInserida <=21.7){
                        altura = 150;
                      }
                      if (alturaInserida >=21.8 && alturaInserida <= 22.2){
                        altura = 152;
                      }
                      if (alturaInserida >=22.3 && alturaInserida <=22.7){
                        altura = 153;
                      }
                      if (alturaInserida >=22.8 && alturaInserida <= 23.2){
                        altura = 155;
                      }
                      if (alturaInserida >=23.3 && alturaInserida <= 23.7){
                        altura = 156;
                      }
                      if (alturaInserida >=23.8 && alturaInserida <= 24.2){
                        altura = 158;
                      }
                      if (alturaInserida >=24.3 && alturaInserida <= 24.7){
                        altura = 160;
                      }
                      if (alturaInserida >=24.8 && alturaInserida <= 25.2){
                        altura = 161;
                      }
                      if (alturaInserida >=25.3 && alturaInserida <= 25.7){
                        altura = 163;
                      }
                      if (alturaInserida >=25.8 && alturaInserida <= 26.2){
                        altura = 165;
                      }
                      if (alturaInserida >=26.3 && alturaInserida <= 26.7){
                        altura = 166;
                      }
                      if (alturaInserida >=26.8 && alturaInserida <= 27.2){
                        altura = 168;
                      }
                      if (alturaInserida >=27.3 && alturaInserida <= 27.7){
                        altura = 170;
                      }
                      if (alturaInserida >=27.8 && alturaInserida <= 28.2){
                        altura = 171;
                      }
                      if (alturaInserida >=28.3 && alturaInserida <= 28.7){
                        altura = 173;
                      }
                      if (alturaInserida >=28.8 && alturaInserida <= 29.2){
                        altura = 175;
                      }
                      if (alturaInserida >=29.3 && alturaInserida <= 29.7){
                        altura = 176;
                      }
                      if (alturaInserida >=29.8 && alturaInserida <= 30.2){
                        altura = 178;
                      }
                      if (alturaInserida >=30.3 && alturaInserida <= 30.7){
                        altura = 179;
                      }
                      if (alturaInserida >=30.8 && alturaInserida <= 31.2){
                        altura = 181;
                      }
                      if (alturaInserida >=31.3 && alturaInserida <= 31.7){
                        altura = 183;
                      }
                      if (alturaInserida >=31.8){
                        altura = 184;
                      }
                    } 
                    else{
                      //homem
                      if (alturaInserida >=1 && alturaInserida <= 18.7){
                        altura = 145;
                      }
                      if (alturaInserida >=18.8 && alturaInserida <= 19.2){
                        altura = 146;
                      }
                      if (alturaInserida >=19.3 && alturaInserida <= 19.7){
                        altura = 148;
                      }
                      if (alturaInserida >=19.8 && alturaInserida <= 20.2){
                        altura = 149;
                      }
                      if (alturaInserida >=20.3 && alturaInserida <=20.7){
                        altura = 151;
                      }
                      if (alturaInserida >=20.8 && alturaInserida <= 21.2){
                        altura = 152;
                      }
                      if (alturaInserida >=21.3 && alturaInserida <=21.7){
                        altura = 154;
                      }
                      if (alturaInserida >=21.8 && alturaInserida <= 22.2){
                        altura = 156;
                      }
                      if (alturaInserida >=22.3 && alturaInserida <=22.7){
                        altura = 157;
                      }
                      if (alturaInserida >=22.8 && alturaInserida <= 23.2){
                        altura = 159;
                      }
                      if (alturaInserida >=23.3 && alturaInserida <= 23.7){
                        altura = 160;
                      }
                      if (alturaInserida >=23.8 && alturaInserida <= 24.2){
                        altura = 162;
                      }
                      if (alturaInserida >=24.3 && alturaInserida <= 24.7){
                        altura = 163;
                      }
                      if (alturaInserida >=24.8 && alturaInserida <= 25.2){
                        altura = 165;
                      }
                      if (alturaInserida >=25.3 && alturaInserida <= 25.7){
                        altura = 167;
                      }
                      if (alturaInserida >=25.8 && alturaInserida <= 26.2){
                        altura = 168;
                      }
                      if (alturaInserida >=26.3 && alturaInserida <= 26.7){
                        altura = 170;
                      }
                      if (alturaInserida >=26.8 && alturaInserida <= 27.2){
                        altura = 171;
                      }
                      if (alturaInserida >=27.3 && alturaInserida <= 27.7){
                        altura = 173;
                      }
                      if (alturaInserida >=27.8 && alturaInserida <= 28.2){
                        altura = 175;
                      }
                      if (alturaInserida >=28.3 && alturaInserida <= 28.7){
                        altura = 176;
                      }
                      if (alturaInserida >=28.8 && alturaInserida <= 29.2){
                        altura = 178;
                      }
                      if (alturaInserida >=29.3 && alturaInserida <= 29.7){
                        altura = 179;
                      }
                      if (alturaInserida >=29.8 && alturaInserida <= 30.2){
                        altura = 181;
                      }
                      if (alturaInserida >=30.3 && alturaInserida <= 30.7){
                        altura = 182;
                      }
                      if (alturaInserida >=30.8 && alturaInserida <= 31.2){
                        altura = 184;
                      }
                      if (alturaInserida >=31.3 && alturaInserida <= 31.7){
                        altura = 186;
                      }
                      if (alturaInserida >=31.8){
                        altura = 187;
                      }
                    }
                  } 
                  else{
                    //idade menor que 65
                    if(selectedGender == 1){
                      //mulher
                      if (alturaInserida >=1 && alturaInserida <= 18.7){
                        altura = 147;
                      }
                      if (alturaInserida >=18.8 && alturaInserida <= 19.2){
                        altura = 148;
                      }
                      if (alturaInserida >=19.3 && alturaInserida <= 19.7){
                        altura = 150;
                      }
                      if (alturaInserida >=19.8 && alturaInserida <= 20.2){
                        altura = 151;
                      }
                      if (alturaInserida >=20.3 && alturaInserida <=20.7){
                        altura = 152;
                      }
                      if (alturaInserida >=20.8 && alturaInserida <= 21.2){
                        altura = 154;
                      }
                      if (alturaInserida >=21.3 && alturaInserida <=21.7){
                        altura = 155;
                      }
                      if (alturaInserida >=21.8 && alturaInserida <= 22.2){
                        altura = 156;
                      }
                      if (alturaInserida >=22.3 && alturaInserida <=22.7){
                        altura = 158;
                      }
                      if (alturaInserida >=22.8 && alturaInserida <= 23.2){
                        altura = 159;
                      }
                      if (alturaInserida >=23.3 && alturaInserida <= 23.7){
                        altura = 161;
                      }
                      if (alturaInserida >=23.8 && alturaInserida <= 24.2){
                        altura = 162;
                      }
                      if (alturaInserida >=24.3 && alturaInserida <= 24.7){
                        altura = 163;
                      }
                      if (alturaInserida >=24.8 && alturaInserida <= 25.2){
                        altura = 165;
                      }
                      if (alturaInserida >=25.3 && alturaInserida <= 25.7){
                        altura = 166;
                      }
                      if (alturaInserida >=25.8 && alturaInserida <= 26.2){
                        altura = 168;
                      }
                      if (alturaInserida >=26.3 && alturaInserida <= 26.7){
                        altura = 169;
                      }
                      if (alturaInserida >=26.8 && alturaInserida <= 27.2){
                        altura = 170;
                      }
                      if (alturaInserida >=27.3 && alturaInserida <= 27.7){
                        altura = 172;
                      }
                      if (alturaInserida >=27.8 && alturaInserida <= 28.2){
                        altura = 173;
                      }
                      if (alturaInserida >=28.3 && alturaInserida <= 28.7){
                        altura = 175;
                      }
                      if (alturaInserida >=28.8 && alturaInserida <= 29.2){
                        altura = 176;
                      }
                      if (alturaInserida >=29.3 && alturaInserida <= 29.7){
                        altura = 177;
                      }
                      if (alturaInserida >=29.8 && alturaInserida <= 30.2){
                        altura = 179;
                      }
                      if (alturaInserida >=30.3 && alturaInserida <= 30.7){
                        altura = 180;
                      }
                      if (alturaInserida >=30.8 && alturaInserida <= 31.2){
                        altura = 181;
                      }
                      if (alturaInserida >=31.3 && alturaInserida <= 31.7){
                        altura = 183;
                      }
                      if (alturaInserida >=31.8){
                        altura = 184;
                      }
                    }else{
                      //homem
                      if (alturaInserida >=1 && alturaInserida <= 18.7){
                        altura = 146;
                      }
                      if (alturaInserida >=18.8 && alturaInserida <= 19.2){
                        altura = 148;
                      }
                      if (alturaInserida >=19.3 && alturaInserida <= 19.7){
                        altura = 149;
                      }
                      if (alturaInserida >=19.8 && alturaInserida <= 20.2){
                        altura = 151;
                      }
                      if (alturaInserida >=20.3 && alturaInserida <=20.7){
                        altura = 153;
                      }
                      if (alturaInserida >=20.8 && alturaInserida <= 21.2){
                        altura = 155;
                      }
                      if (alturaInserida >=21.3 && alturaInserida <=21.7){
                        altura = 157;
                      }
                      if (alturaInserida >=21.8 && alturaInserida <= 22.2){
                        altura = 158;
                      }
                      if (alturaInserida >=22.3 && alturaInserida <=22.7){
                        altura = 160;
                      }
                      if (alturaInserida >=22.8 && alturaInserida <= 23.2){
                        altura = 162;
                      }
                      if (alturaInserida >=23.3 && alturaInserida <= 23.7){
                        altura = 164;
                      }
                      if (alturaInserida >=23.8 && alturaInserida <= 24.2){
                        altura = 166;
                      }
                      if (alturaInserida >=24.3 && alturaInserida <= 24.7){
                        altura = 167;
                      }
                      if (alturaInserida >=24.8 && alturaInserida <= 25.2){
                        altura = 169;
                      }
                      if (alturaInserida >=25.3 && alturaInserida <= 25.7){
                        altura = 171;
                      }
                      if (alturaInserida >=25.8 && alturaInserida <= 26.2){
                        altura = 173;
                      }
                      if (alturaInserida >=26.3 && alturaInserida <= 26.7){
                        altura = 175;
                      }
                      if (alturaInserida >=26.8 && alturaInserida <= 27.2){
                        altura = 176;
                      }
                      if (alturaInserida >=27.3 && alturaInserida <= 27.7){
                        altura = 178;
                      }
                      if (alturaInserida >=27.8 && alturaInserida <= 28.2){
                        altura = 180;
                      }
                      if (alturaInserida >=28.3 && alturaInserida <= 28.7){
                        altura = 182;
                      }
                      if (alturaInserida >=28.8 && alturaInserida <= 29.2){
                        altura = 184;
                      }
                      if (alturaInserida >=29.3 && alturaInserida <= 29.7){
                        altura = 185;
                      }
                      if (alturaInserida >=29.8 && alturaInserida <= 30.2){
                        altura = 187;
                      }
                      if (alturaInserida >=30.3 && alturaInserida <= 30.7){
                        altura = 189;
                      }
                      if (alturaInserida >=30.8 && alturaInserida <= 31.2){
                        altura = 191;
                      }
                      if (alturaInserida >=31.3 && alturaInserida <= 31.7){
                        altura = 193;
                      }
                      if (alturaInserida >=31.8){
                        altura = 194;
                      }
                    }
                  }
                  print('altura: $altura cm');

                }else {
                  print('altura total');
                }
                if (selectedGender == 1) {
                  print('feminino');
                  genero = 'feminino';
                } else{ 
                  print('masculino');
                  genero = 'masculino';
                  };
                
                if (condicoes[0]['value'] == true){
                  print (condicoes[0]['title']);
                }

                CollectionReference colRef = FirebaseFirestore.instance.collection('pacientes');
                colRef.add({
                  'nome': nameController.text,
                  'nascimento': data,
                  'genero': genero,
                  'altura': altura,
                  'sdra': condicoes[0]['value'],
                  'dpco': condicoes[1]['value'],
                  'obeso': condicoes[2]['value'],
                  'neurocritico': condicoes[3]['value']
                });
              },
              child: const Text('Salvar'),
              ),
            )
                  ],      
                ),
          ),
      ), 
    ),
  );// TODO: implement build
  }
}