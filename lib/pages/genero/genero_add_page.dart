import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/genero.dart';
import 'package:acervo/services/genero_services.dart';
import 'package:flutter/material.dart';

class GeneroAddPage extends StatefulWidget {
  const GeneroAddPage({super.key});

  @override
  State<GeneroAddPage> createState() => _GeneroAddPageState();
}

class _GeneroAddPageState extends State<GeneroAddPage> {
  final TextEditingController _nomeController = TextEditingController();
  final Genero genero = Genero();
  final GeneroServices generoServices = GeneroServices();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 100,
        ),
        child: Column(
          children: [
            Text(
              'Adicionar Gênero',
              style: TextStyle(
                color: const Color.fromARGB(255, 1, 17, 1),
                fontSize: Responsive.isDesktop(context)
                    ? 25
                    : Responsive.isTablet(context)
                        ? 22
                        : 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(hintText: 'Nome'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 17, 1),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 17, 1),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    genero.nome = _nomeController.text;
                    generoServices.addGenero(
                      genero: genero,
                    );
                    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
                      _nomeController.clear();
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 17, 1),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
