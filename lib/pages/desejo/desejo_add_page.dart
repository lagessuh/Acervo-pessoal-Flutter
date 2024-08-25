import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/desejo.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/commons/utils.dart';
import 'package:acervo/services/desejo_services.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DesejoAddPage extends StatelessWidget {
  const DesejoAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    CategoriaServices categoriaServices = CategoriaServices();
    //-- criando variável para instanciar a classe de dados da cotação
    Desejo desejo = Desejo();
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                  //-- dropdown para commodity
                  DropdownSearch<Categoria>(
                    popupProps: PopupPropsMultiSelection.menu(
                      itemBuilder: _listCommodity,
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
                                initialValue: Utilities.getDateTime(),
                                decoration: InputDecoration(
                                  label: const Text(
                                    'Dia',
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 12, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 12, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onSaved: (value) {
                                  //-- definindo padrão de entrada para a data
                                  var inputFormat = DateFormat('dd-MM-yyyy');
                                  //-- conversão do dado da variável "value" de String para data (DateTime)
                                  var inputDate = inputFormat.parse(value!);
                                  //-- formato do padrão inglês (americano) para o padrão brasileiro (pt_BR)
                                  DateFormat outputFormat =
                                      DateFormat('yyyy-MM-dd', 'pt_BR');
                                  //-- convertendo para o formato brasileiro
                                  var outDate = outputFormat.format(inputDate);
                                  //-converte a data em formato String para o formato DateTime
                                  DateTime now = DateTime.parse(outDate);
                                  desejo.data = now;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
                                      //-- popular a classe de dados da cotação com os dados da UI
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        DesejoServices quoteServices =
                                            DesejoServices();
                                        bool ok = await quoteServices.addDesejo(
                                            desejo: desejo);
                                        if (ok) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Dados da cotação foram gravados com sucesso'),
                                            backgroundColor:
                                                Colors.amberAccent[400],
                                            duration:
                                                const Duration(seconds: 5),
                                          ));
                                          myToastDialog(
                                              msg:
                                                  'Cotação gravada com sucesso!!!');
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Problemas ao gravar dados da cotação'),
                                            backgroundColor:
                                                Colors.amberAccent[400],
                                            duration:
                                                const Duration(seconds: 5),
                                          ));
                                          myToastDialog(
                                              msg:
                                                  'Cotação gravada com sucesso!!!');
                                        }
                                      }
                                    },
                                    child: const Text('Salvar'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listCommodity(
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
