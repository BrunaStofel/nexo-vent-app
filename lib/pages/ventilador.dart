import 'package:flutter/material.dart';

class Ventilador extends StatefulWidget {
  Ventilador({Key? key}) : super(key: key);

    @override
  _Ventilador createState() => _Ventilador();
}

class _Ventilador extends State<Ventilador> {
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
                      Text('Ajuste inicial do ventilador'),
                    ]
                  )
                  ),
              ),

            const SizedBox(height: 30),

              // flex: 1,
               SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Paciente está no ventilador'),
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