import 'package:acervo/models/genero.dart';
import 'package:acervo/services/genero_services.dart';
import 'package:flutter/material.dart';

class GeneroEditPage extends StatelessWidget {
  GeneroEditPage({super.key, this.genero});
  final Genero? genero;

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = genero!.nome!;
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(172, 214, 198, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Editando Genero',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'id: ${genero!.id}',
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
                          genero!.nome = _nameController.text;
                          GeneroServices generoServices = GeneroServices();
                          generoServices
                              .updateGenero(genero!)
                              .then((value) => Navigator.pop(context));
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Atualizar')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
