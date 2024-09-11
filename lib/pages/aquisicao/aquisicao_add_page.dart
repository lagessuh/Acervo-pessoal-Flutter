import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/services/aquisicao_services.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AquisicaoAddPage extends StatefulWidget {
  const AquisicaoAddPage({super.key});

  @override
  State<AquisicaoAddPage> createState() => _AquisicaoAddPageState();
}

class _AquisicaoAddPageState extends State<AquisicaoAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final Aquisicao aquisicao = Aquisicao();
  final AquisicaoServices aquisicaoServices = AquisicaoServices();

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
                // padding: const EdgeInsets.symmetric(
                //   vertical: 30.0,
                //   horizontal: 100,
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar Local de Aquisição',
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
                      decoration: const InputDecoration(
                          hintText: 'Nome do Local ou Nome de quem presenteou'),
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
                            aquisicao.nome = _nomeController.text;
                            aquisicaoServices.addAquisicao(
                              aquisicao: aquisicao,
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
