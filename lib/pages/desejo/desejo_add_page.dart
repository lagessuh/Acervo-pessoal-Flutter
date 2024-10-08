import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/desejo.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/services/desejo_services.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DesejoAddPage extends StatefulWidget {
  const DesejoAddPage({super.key});

  @override
  State<DesejoAddPage> createState() => _DesejoAddPageState();
}

class _DesejoAddPageState extends State<DesejoAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoriaServices categoriaServices = CategoriaServices();
  DesejoServices desejoServices = DesejoServices();
  Desejo desejo = Desejo();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

// Listas para os dropdowns
  List<String> statusDesejo = ['Não', 'Sim'];

  // Variáveis para armazenar as opções selecionadas
  String? statusSelecionado;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(172, 214, 198, 255),
              borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Consumer<UserServices>(
              builder: (context, userServices, __) {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'Lista de Desejos',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _nomeController,
                          decoration: const InputDecoration(hintText: 'Nome'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 17, 1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _autorController,
                          decoration: const InputDecoration(hintText: 'Autor'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 17, 1),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownSearch<Categoria>(
                          popupProps: PopupPropsMultiSelection.menu(
                            itemBuilder: _listCategoria,
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          compareFn: (item, sItem) => item.id == sItem.id,
                          asyncItems: (String? filter) =>
                              categoriaServices.getAllCategoriaDesejo(filter!),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Categoria',
                              filled: true,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          onSaved: (value) {
                            Categoria categoria = Categoria();
                            categoria.id = value!.id;
                            categoria.nome = value!.nome;
                            desejo.categoria = categoria;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'A Categoria deve ser fornecido!!!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _dataController,
                                      decoration: const InputDecoration(
                                          hintText: 'Data de Cadastro'),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 1, 17, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                    labelText: "Desejo realizado?",
                                    border: OutlineInputBorder()),
                                value: statusSelecionado,
                                onChanged: (String? novoValor) {
                                  setState(() {
                                    statusSelecionado = novoValor!;
                                  });
                                },
                                items: statusDesejo.map((String tipo) {
                                  return DropdownMenuItem<String>(
                                    value: tipo,
                                    child: Text(tipo),
                                  );
                                }).toList(),
                                onSaved: (String? value) {
                                  if (value != null) {
                                    desejo.status =
                                        value; // Atualiza o valor de avaliação no item
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  //-- botão para fechar
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Sair'))),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  //-- botão para salver
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          // Atualize o item com os dados do formulário
                                          desejo.nome = _nomeController.text;
                                          desejo.autor = _autorController.text;
                                          desejo.data = _dataController.text;

                                          DesejoServices desejoServices =
                                              DesejoServices();
                                          bool ok = await desejoServices
                                              .addDesejo(desejo: desejo);

                                          if (ok) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                    'Dados do item foram gravados com sucesso'),
                                                backgroundColor:
                                                    Colors.amberAccent[400],
                                                duration:
                                                    const Duration(seconds: 5),
                                              ),
                                            );
                                            myToastDialog(
                                                msg:
                                                    'Item gravado com sucesso!!!');

                                            // Limpar campos e fechar a página após um breve atraso
                                            Future.delayed(
                                                    const Duration(seconds: 2))
                                                .whenComplete(() {
                                              _nomeController.clear();
                                              _autorController.clear();
                                              _dataController.clear();
                                              Navigator.of(context).pop();
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                    'Problemas ao gravar dados do item'),
                                                backgroundColor:
                                                    Colors.amberAccent[400],
                                                duration:
                                                    const Duration(seconds: 5),
                                              ),
                                            );
                                            myToastDialog(
                                                msg:
                                                    'Problemas ao gravar item!!!');
                                          }
                                        }
                                      },
                                      child: const Text('Salvar'),
                                    ),
                                  ),
                                ],
                              )
                            ]))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _listCategoria(
      BuildContext context, Categoria categoria, bool isSelected) {
    return Container(
      child: ListTile(
        title: Text(categoria.nome!),
      ),
    );
  }
}

Future<bool?> myToastDialog(
    {required String msg,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white}) {
  return Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 14,
  );
}
