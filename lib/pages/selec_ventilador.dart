import 'package:flutter/material.dart';

class SelecVentilador extends StatefulWidget {
  SelecVentilador({Key? key}) : super(key: key);

    @override
  _SelecVentilador createState() => _SelecVentilador();
}

class _SelecVentilador extends State<SelecVentilador> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Escolha o modelo do VM'),   

            const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Maquet Servo-i'),
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
                      Text('Maquet Servo-S'),
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