import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/desejo.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/services/desejo_services.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DesejoEditPage extends StatefulWidget {
  final Desejo desejo; // Objeto Desejo para edição

  const DesejoEditPage({super.key, required this.desejo});

  @override
  State<DesejoEditPage> createState() => _DesejoEditPageState();
}

class _DesejoEditPageState extends State<DesejoEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoriaServices categoriaServices = CategoriaServices();
  DesejoServices desejoServices = DesejoServices();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  // Lista para o dropdown de status
  List<String> statusDesejo = ['Não', 'Sim'];
  String? statusSelecionado;

  Desejo desejo = Desejo();

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com os dados do objeto Desejo
    _nomeController.text = widget.desejo.nome ?? '';
    _autorController.text = widget.desejo.autor ?? '';
    _dataController.text = widget.desejo.data ?? '';
    statusSelecionado = widget.desejo.status ?? statusDesejo[0];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(172, 214, 198, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Editar Desejo',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'id: ${widget.desejo!.id}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 17, 1),
                      ),
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
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      selectedItem: widget.desejo.categoria, // Categoria atual
                      onSaved: (value) {
                        if (value is Categoria) {
                          widget.desejo.categoria =
                              value; // Certifique-se de atribuir corretamente a categoria
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'A Categoria deve ser fornecida!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _dataController,
                      decoration: const InputDecoration(hintText: 'Data'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 17, 1),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Desejo realizado?",
                        border: OutlineInputBorder(),
                      ),
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
                          widget.desejo.status = value;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                // Atualiza o objeto desejo com os novos dados do formulário
                                widget.desejo.nome = _nomeController.text;
                                widget.desejo.autor = _autorController.text;
                                widget.desejo.data = _dataController.text;

                                // Chama o método updateDesejo passando o objeto desejo como parâmetro
                                bool ok = await desejoServices.updateDesejo(widget
                                    .desejo); // Passa o objeto atualizado aqui

                                if (ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Desejo atualizado com sucesso'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 5),
                                    ),
                                  );

                                  // Limpa os campos e fecha a página após um breve atraso
                                  Future.delayed(const Duration(seconds: 2))
                                      .whenComplete(() {
                                    _nomeController.clear();
                                    _autorController.clear();
                                    _dataController.clear();
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Erro ao atualizar o desejo'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                }
                              }
                            },
                            //   if (_formKey.currentState!.validate()) {
                            //     _formKey.currentState!.save();

                            //     // Atualize o item com os dados do formulário
                            //     desejo.nome = _nomeController.text;
                            //     desejo.autor = _autorController.text;
                            //     desejo.data = _dataController.text;

                            //     DesejoServices desejoServices =
                            //         DesejoServices();
                            //     bool ok =
                            //         await desejoServices.updateDesejo(desejo);

                            //     if (ok) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //           content: const Text(
                            //               'Dados do item foram gravados com sucesso'),
                            //           backgroundColor: Colors.amberAccent[400],
                            //           duration: const Duration(seconds: 5),
                            //         ),
                            //       );
                            //       myToastDialog(
                            //           msg: 'Item gravado com sucesso!!!');

                            //       // Limpar campos e fechar a página após um breve atraso
                            //       Future.delayed(const Duration(seconds: 2))
                            //           .whenComplete(() {
                            //         _nomeController.clear();
                            //         _autorController.clear();
                            //         _dataController.clear();
                            //         Navigator.of(context).pop();
                            //       });
                            //     } else {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //           content: const Text(
                            //               'Problemas ao gravar dados do item'),
                            //           backgroundColor: Colors.amberAccent[400],
                            //           duration: const Duration(seconds: 5),
                            //         ),
                            //       );
                            //       myToastDialog(
                            //           msg: 'Problemas ao gravar item!!!');
                            //     }
                            //   }
                            // },
                            child: const Text('Salvar'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listCategoria(
      BuildContext context, Categoria categoria, bool isSelected) {
    return ListTile(
      title: Text(categoria.nome!),
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
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14,
  );
}
