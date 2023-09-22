import 'package:flutter/material.dart';

class Paciente extends StatefulWidget {
  Paciente({Key? key}) : super(key: key);

    @override
  _Paciente createState() => _Paciente();
}

class _Paciente extends State<Paciente> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              // flex: 1,
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.person_add_alt_outlined),
                      Text('Novo paciente'),
                    ]
                  )
                  ),
              ),

            const SizedBox(height: 30),
               SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.dehaze),
                      Text('Listar pacientes'),
                    ]
                  )
                  ),
              ),
          ],
        )
      ,)
    );
  }
}