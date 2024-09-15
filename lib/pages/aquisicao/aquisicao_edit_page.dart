import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/services/aquisicao_services.dart';
import 'package:flutter/material.dart';

class AquisicaoEditPage extends StatelessWidget {
  AquisicaoEditPage({super.key, this.aquisicao});
  final Aquisicao? aquisicao;

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = aquisicao!.nome!;
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'Editando Local de Aquisição',
              style: TextStyle(
                fontSize: 30,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'id: ${aquisicao!.id}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 17, 1),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Nome:'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.2),
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 17, 1),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancelar')),
                OutlinedButton.icon(
                    onPressed: () {
                      aquisicao!.nome = _nameController.text;
                      AquisicaoServices aquisicaoServices = AquisicaoServices();
                      aquisicaoServices
                          .updateAquisicao(aquisicao!)
                          .then((value) => Navigator.pop(context));
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Atualizar')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
