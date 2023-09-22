import 'package:flutter/material.dart';

class ListarPacientes extends StatefulWidget {
  ListarPacientes({Key? key}) : super(key: key);

    @override
  _ListarPacientesState createState() => _ListarPacientesState();
}

class _ListarPacientesState extends State<ListarPacientes> {
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
            Expanded(
              flex: 10,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text('Paciente $index'),
                    trailing: const Icon(Icons.chevron_right),
                  );
                }), 
                separatorBuilder:  (__, _) => const Divider(), 
                itemCount: 15)
            ),
          ],
        )
      ,)
    );
  }
}