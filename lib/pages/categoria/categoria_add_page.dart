import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaAddPage extends StatefulWidget {
  const CategoriaAddPage({super.key});

  @override
  State<CategoriaAddPage> createState() => _CategoriaAddPageState();
}

class _CategoriaAddPageState extends State<CategoriaAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final Categoria categoria = Categoria();
  final CategoriaServices categoriaServices = CategoriaServices();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(172, 214, 198, 255),
            borderRadius: BorderRadius.circular(20)),
        child: Consumer<UserServices>(
          builder: (context, userServices, __) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    Text(
                      'Adicionar Categoria',
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
                            categoria.nome = _nomeController.text;
                            categoriaServices.addCategoria(
                              categoria: categoria,
                            );
                            Future.delayed(const Duration(seconds: 2))
                                .whenComplete(() {
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
          },
        ),
      ),
    ));
  }
}
