// import 'package:acervo/commons/widgets/my_textformfield.dart';
// import 'package:acervo/models/aquisicao.dart';
// import 'package:acervo/models/categoria.dart';
// import 'package:acervo/models/genero.dart';
// import 'package:acervo/models/item.dart';
// import 'package:acervo/services/aquisicao_services.dart';
// import 'package:acervo/services/categoria_services.dart';
// import 'package:acervo/services/genero_services.dart';
// import 'package:acervo/services/item_services.dart';
// import 'package:acervo/services/user_services.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// class ItemAddPage extends StatefulWidget {
//   const ItemAddPage({super.key});

//   @override
//   State<ItemAddPage> createState() => _ItemAddPageState();
// }

// class _ItemAddPageState extends State<ItemAddPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   AquisicaoServices aquisicaoServices = AquisicaoServices();
//   GeneroServices generoServices = GeneroServices();
//   CategoriaServices categoriaServices = CategoriaServices();
//   final TextEditingController _nomeController = TextEditingController();
//   final TextEditingController _edicaoController = TextEditingController();
//   final TextEditingController _autorController = TextEditingController();
//   final TextEditingController _dataController = TextEditingController();
//   final TextEditingController _dataLancamentoController =
//       TextEditingController();

//   // Listas para os dropdowns
//   List<String> tiposDeItem = ['Físico', 'Digital'];
//   List<String> avaliacoes = ['Excelente', 'Bom', 'Regular', 'Ruim', 'Péssimo'];

//   // Variáveis para armazenar as opções selecionadas
//   String? tipoSelecionado;
//   String? avaliacaoSelecionada;

//   @override
//   Widget build(BuildContext context) {
//     //-- criando variável para instanciar a classe de dados do item
//     Item item = Item();
//     // final aquisicaoServices = Provider.of<AquisicaoServices>(context);
//     // final generoServices = Provider.of<GeneroServices>(context);
//     // final categoriaServices = Provider.of<CategoriaServices>(context);

//     return Material(
//         child: SafeArea(
//       child: Container(
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(172, 214, 198, 255),
//             borderRadius: BorderRadius.circular(20)),
//         child: SingleChildScrollView(
//           child: Consumer<UserServices>(builder: (context, userServices, __) {
//             return Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(60.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),
//                     const Text(
//                       'Registro de Itens',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     //campo nome do item
//                     MyTextFormField(
//                       controller: _nomeController,
//                       onSaved: (value) => item.nome = value,
//                       onChanged: (value) {},
//                       labelText: 'Nome',
//                       textType: TextInputType.text,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Nome é obrigatório';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     //campo autor do item
//                     MyTextFormField(
//                       controller: _autorController,
//                       onSaved: (value) => item.autor = value,
//                       onChanged: (value) {},
//                       labelText: 'Autor',
//                       textType: TextInputType.text,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Nome é obrigatório';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     //campo de descrição do número de edição
//                     MyTextFormField(
//                       controller: _edicaoController,
//                       onSaved: (value) => item.edicao = value,
//                       onChanged: (value) {},
//                       labelText: 'Edição',
//                       textType: TextInputType.text,
//                     ),
//                     const SizedBox(height: 20),
//                     //colocar um dropdown com o tipo do item, físico ou digital
//                     DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                           labelText: "Tipo do Item",
//                           border: OutlineInputBorder()),
//                       value: tipoSelecionado,
//                       onChanged: (String? novoValor) {
//                         setState(() {
//                           tipoSelecionado = novoValor!;
//                         });
//                       },
//                       items: tiposDeItem.map((String tipo) {
//                         return DropdownMenuItem<String>(
//                           value: tipo,
//                           child: Text(tipo),
//                         );
//                       }).toList(),
//                       onSaved: (String? value) {
//                         if (value != null) {
//                           item.tipo =
//                               value; // Atualiza o valor de avaliação no item
//                         }
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Tipo do Item é obrigatório';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     //colocar um dropdown com a avaliação do item: excelente, bom, regular, ruim, péssimo
//                     DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                           labelText: "Avaliação", border: OutlineInputBorder()),
//                       value: avaliacaoSelecionada,
//                       onChanged: (String? novoValor) {
//                         setState(() {
//                           avaliacaoSelecionada = novoValor!;
//                         });
//                       },
//                       items: avaliacoes.map((String avaliacao) {
//                         return DropdownMenuItem<String>(
//                           value: avaliacao,
//                           child: Text(avaliacao),
//                         );
//                       }).toList(),
//                       onSaved: (String? value) {
//                         if (value != null) {
//                           item.avaliacao =
//                               value; // Atualiza o valor de avaliação no item
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     //-- dropdown dos locais de aquisicao
//                     DropdownSearch<Aquisicao>(
//                       popupProps: PopupPropsMultiSelection.menu(
//                         itemBuilder: _listAquisicoes,
//                         showSelectedItems: true,
//                         showSearchBox: true,
//                       ),
//                       compareFn: (item, sItem) => item.id == sItem.id,
//                       asyncItems: (String? filter) =>
//                           aquisicaoServices.getAllAquisicoesItem(filter!),
//                       dropdownDecoratorProps: DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                           labelText: 'Aquisição',
//                           filled: true,
//                           fillColor:
//                               Theme.of(context).inputDecorationTheme.fillColor,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.black),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),
//                       onSaved: (value) {
//                         Aquisicao aquisicao = Aquisicao();
//                         aquisicao.id = value!.id;
//                         aquisicao.nome = value!.nome;
//                         item.aquisicao = aquisicao;
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Nome do Local de Aquisição!!!';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     //-- dropdown dos generos registrados
//                     DropdownSearch<Genero>(
//                       asyncItems: (String? filter) =>
//                           generoServices.getAllGenerosItem(filter!),
//                       compareFn: (item, sItem) => item.id == sItem.id,
//                       popupProps: PopupPropsMultiSelection.menu(
//                           itemBuilder: _listGeneros,
//                           showSearchBox: true,
//                           showSelectedItems: true),
//                       dropdownDecoratorProps: DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                           labelText: 'Gênero',
//                           filled: true,
//                           fillColor:
//                               Theme.of(context).inputDecorationTheme.fillColor,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.black),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),
//                       onSaved: (value) {
//                         Genero genero = Genero();
//                         genero.id = value!.id;
//                         genero.nome = value.nome;
//                         item.genero = genero;
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'A gênero deve ser preenchida!!!';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     DropdownSearch<Categoria>(
//                       asyncItems: (String? filter) =>
//                           categoriaServices.getAllCategoriasItem(filter!),
//                       compareFn: (item, sItem) => item.id == sItem.id,
//                       popupProps: PopupPropsMultiSelection.menu(
//                           itemBuilder: _listCategorias,
//                           showSearchBox: true,
//                           showSelectedItems: true),
//                       dropdownDecoratorProps: DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                           labelText: 'Categoria',
//                           filled: true,
//                           fillColor:
//                               Theme.of(context).inputDecorationTheme.fillColor,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.blue),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Colors.black),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),
//                       onSaved: (value) {
//                         Categoria categoria = Categoria();
//                         categoria.id = value!.id;
//                         categoria.nome = value.nome;
//                         item.categoria = categoria;
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'A Categoria deve ser preenchida!!!';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     MyTextFormField(
//                       controller: _dataController,
//                       onSaved: (value) => item.data = value,
//                       onChanged: (value) {},
//                       labelText: 'Data de Cadastro',
//                       textType: TextInputType.text,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Data é obrigatório';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     MyTextFormField(
//                       controller: _dataLancamentoController,
//                       onSaved: (value) => item.dataLancamento = value,
//                       onChanged: (value) {},
//                       labelText: 'Data de Lançamento',
//                       textType: TextInputType.text,
//                     ),
//                     const SizedBox(height: 50),
//                     Row(
//                       children: [
//                         //-- botão para fechar
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Text('Sair'))),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Expanded(
//                             child: ElevatedButton(
//                                 onPressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     _formKey.currentState!.save();
//                                     ItemServices itemServices = ItemServices();
//                                     bool ok =
//                                         await itemServices.addItem(item: item);
//                                     if (ok) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                         content: const Text(
//                                             'Dados do item foram gravados com sucesso'),
//                                         backgroundColor:
//                                             Colors.amberAccent[400],
//                                         duration: const Duration(seconds: 5),
//                                       ));
//                                       myToastDialog(
//                                           msg: 'Item gravado com sucesso!!!');
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                         content: const Text(
//                                             'Problemas ao gravar dados do item'),
//                                         backgroundColor:
//                                             Colors.amberAccent[400],
//                                         duration: const Duration(seconds: 5),
//                                       ));
//                                       myToastDialog(
//                                           msg:
//                                               'Item cadastrado com sucesso!!!');
//                                     }
//                                   }
//                                 },
//                                 child: const Text('Salvar'))),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     ));
//   }

//   Widget _listAquisicoes(
//       BuildContext context, Aquisicao aquisicao, bool isSelected) {
//     return Container(
//       child: ListTile(
//         title: Text(aquisicao.nome!),
//       ),
//     );
//   }

//   Widget _listGeneros(BuildContext context, Genero genero, bool isSelected) {
//     return Container(
//       child: ListTile(
//         title: Text(genero.nome!),
//       ),
//     );
//   }

//   Widget _listCategorias(
//       BuildContext context, Categoria categoria, bool isSelected) {
//     return Container(
//       child: ListTile(
//         title: Text(categoria.nome!),
//       ),
//     );
//   }
// }

// Future<bool?> myToastDialog(
//     {required String msg,
//     Color backgroundColor = Colors.black,
//     Color textColor = Colors.white}) {
//   return Fluttertoast.showToast(
//     msg: msg,
//     gravity: ToastGravity.TOP,
//     timeInSecForIosWeb: 2,
//     backgroundColor: Colors.black,
//     textColor: Colors.white,
//     fontSize: 14,
//   );
// }

import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/genero.dart';
import 'package:acervo/models/item.dart';
//import 'package:acervo/commons/utils.dart';
import 'package:acervo/services/aquisicao_services.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/services/genero_services.dart';
import 'package:acervo/services/item_services.dart';
import 'package:acervo/services/user_services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItemAddPage extends StatefulWidget {
  const ItemAddPage({super.key});

  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AquisicaoServices aquisicaoServices = AquisicaoServices();
  GeneroServices generoServices = GeneroServices();
  CategoriaServices categoriaServices = CategoriaServices();
  ItemServices itemServices = ItemServices();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _edicaoController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _dataLancamentoController =
      TextEditingController();

  // Listas para os dropdowns
  List<String> tiposDeItem = ['Físico', 'Digital'];
  List<String> avaliacoes = ['Excelente', 'Bom', 'Regular', 'Ruim', 'Péssimo'];

  // Variáveis para armazenar as opções selecionadas
  String? tipoSelecionado;
  String? avaliacaoSelecionada;

  @override
  Widget build(BuildContext context) {
    //-- criando variável para instanciar a classe de dados do item
    Item item = Item();
    return Material(
        child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(172, 214, 198, 255),
            borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Consumer<UserServices>(builder: (context, userServices, __) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Registro de Itens',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    //campo nome do item
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
                    //campo de descrição do número de edição
                    TextField(
                      controller: _edicaoController,
                      decoration: const InputDecoration(hintText: 'Edição'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 17, 1),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //campo autor do item
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
                    //colocar um dropdown com o tipo do item, físico ou digital
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: "Tipo do Item",
                          border: OutlineInputBorder()),
                      value: tipoSelecionado,
                      onChanged: (String? novoValor) {
                        setState(() {
                          tipoSelecionado = novoValor!;
                        });
                      },
                      items: tiposDeItem.map((String tipo) {
                        return DropdownMenuItem<String>(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onSaved: (String? value) {
                        if (value != null) {
                          item.tipo =
                              value; // Atualiza o valor de avaliação no item
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    //colocar um dropdown com a avaliação do item: excelente, bom, regular, ruim, péssimo
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: "Avaliação", border: OutlineInputBorder()),
                      value: avaliacaoSelecionada,
                      onChanged: (String? novoValor) {
                        setState(() {
                          avaliacaoSelecionada = novoValor!;
                        });
                      },
                      items: avaliacoes.map((String avaliacao) {
                        return DropdownMenuItem<String>(
                          value: avaliacao,
                          child: Text(avaliacao),
                        );
                      }).toList(),
                      onSaved: (String? value) {
                        if (value != null) {
                          item.avaliacao =
                              value; // Atualiza o valor de avaliação no item
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    //-- dropdown dos locais de aquisicao
                    DropdownSearch<Aquisicao>(
                      popupProps: PopupPropsMultiSelection.menu(
                        itemBuilder: _listAquisicoes,
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      asyncItems: (String? filter) =>
                          aquisicaoServices.getAllAquisicoesItem(filter!),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Aquisição',
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
                        Aquisicao aquisicao = Aquisicao();
                        aquisicao.id = value!.id;
                        aquisicao.nome = value!.nome;
                        item.aquisicao = aquisicao;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Nome do Local de Aquisição!!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //-- dropdown dos generos registrados
                    DropdownSearch<Genero>(
                      asyncItems: (String? filter) =>
                          generoServices.getAllGenerosItem(filter!),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      popupProps: PopupPropsMultiSelection.menu(
                          itemBuilder: _listGeneros,
                          showSearchBox: true,
                          showSelectedItems: true),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Gênero',
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
                        Genero genero = Genero();
                        genero.id = value!.id;
                        genero.nome = value.nome;
                        item.genero = genero;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'A gênero deve ser preenchida!!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownSearch<Categoria>(
                      asyncItems: (String? filter) =>
                          categoriaServices.getAllCategoriasItem(filter!),
                      compareFn: (item, sItem) => item.id == sItem.id,
                      popupProps: PopupPropsMultiSelection.menu(
                          itemBuilder: _listCategorias,
                          showSearchBox: true,
                          showSelectedItems: true),
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
                        categoria.nome = value.nome;
                        item.categoria = categoria;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'A Categoria deve ser preenchida!!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _dataController,
                      decoration:
                          const InputDecoration(hintText: 'Data de Cadastro'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 17, 1),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _dataLancamentoController,
                      decoration:
                          const InputDecoration(hintText: 'Data de Lançamento'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 17, 1),
                      ),
                    ),
                    const SizedBox(height: 50),
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
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                // Atualize o item com os dados do formulário
                                item.nome = _nomeController.text;
                                item.autor = _autorController.text;
                                item.edicao = _edicaoController.text;
                                item.dataLancamento =
                                    _dataLancamentoController.text;
                                item.data = _dataController.text;

                                ItemServices itemServices = ItemServices();
                                bool ok =
                                    await itemServices.addItem(item: item);

                                if (ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Dados do item foram gravados com sucesso'),
                                      backgroundColor: Colors.amberAccent[400],
                                      duration: const Duration(seconds: 5),
                                    ),
                                  );
                                  myToastDialog(
                                      msg: 'Item gravado com sucesso!!!');

                                  // Limpar campos e fechar a página após um breve atraso
                                  Future.delayed(const Duration(seconds: 2))
                                      .whenComplete(() {
                                    _nomeController.clear();
                                    _autorController.clear();
                                    _edicaoController.clear();
                                    _dataController.clear();
                                    _dataLancamentoController.clear();
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          'Problemas ao gravar dados do item'),
                                      backgroundColor: Colors.amberAccent[400],
                                      duration: const Duration(seconds: 5),
                                    ),
                                  );
                                  myToastDialog(
                                      msg: 'Problemas ao gravar item!!!');
                                }
                              }
                            },
                            child: const Text('Salvar'),
                          ),
                        )
                      ],
                    )

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20.0),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           //-- data de cadastro (campo texto)
                    //           Expanded(
                    //             child: TextFormField(
                    //               initialValue: Utilities.getDateTime(),
                    //               decoration: InputDecoration(
                    //                 label: const Text(
                    //                   'Data de Cadastro',
                    //                   selectionColor: Colors.white,
                    //                 ),
                    //                 enabledBorder: OutlineInputBorder(
                    //                   borderSide: const BorderSide(
                    //                     color: Color.fromARGB(255, 0, 12, 1),
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 border: OutlineInputBorder(
                    //                   borderSide: const BorderSide(
                    //                     color: Color.fromARGB(255, 0, 12, 1),
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //               ),
                    //               onSaved: (value) {
                    //                 //-- definindo padrão de entrada para a data
                    //                 var inputFormat = DateFormat('dd-MM-yyyy');
                    //                 //-- conversão do dado da variável "value" de String para data (DateTime)
                    //                 var inputDate = inputFormat.parse(value!);
                    //                 //-- formato do padrão inglês (americano) para o padrão brasileiro (pt_BR)
                    //                 DateFormat outputFormat =
                    //                     DateFormat('yyyy-MM-dd', 'pt_BR');
                    //                 //-- convertendo para o formato brasileiro
                    //                 var outDate =
                    //                     outputFormat.format(inputDate);
                    //                 //-converte a data em formato String para o formato DateTime
                    //                 DateTime now = DateTime.parse(outDate);
                    //                 item.data = now;
                    //               },
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           // data de lançamento (campo texto)
                    //           Expanded(
                    //             child: TextFormField(
                    //               initialValue: Utilities.getDateTime(),
                    //               decoration: InputDecoration(
                    //                 label: const Text(
                    //                   'Data de Lançamento',
                    //                 ),
                    //                 enabledBorder: OutlineInputBorder(
                    //                   borderSide: const BorderSide(
                    //                     color: Color.fromARGB(255, 0, 12, 1),
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 border: OutlineInputBorder(
                    //                   borderSide: const BorderSide(
                    //                     color: Color.fromARGB(255, 0, 12, 1),
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //               ),
                    //               onSaved: (value) {
                    //                 //-- definindo padrão de entrada para a data
                    //                 var inputFormat = DateFormat('dd-MM-yyyy');
                    //                 //-- conversão do dado da variável "value" de String para data (DateTime)
                    //                 var inputDate = inputFormat.parse(value!);
                    //                 //-- formato do padrão inglês (americano) para o padrão brasileiro (pt_BR)
                    //                 DateFormat outputFormat =
                    //                     DateFormat('yyyy-MM-dd', 'pt_BR');
                    //                 //-- convertendo para o formato brasileiro
                    //                 var outDate =
                    //                     outputFormat.format(inputDate);
                    //                 //-converte a data em formato String para o formato DateTime
                    //                 DateTime now = DateTime.parse(outDate);
                    //                 item.dataLancamento = now;
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(
                    //         height: 15,
                    //       ),
                    //       const SizedBox(
                    //         height: 20,
                    //       ),

                    //       //botão de salvar
                    //       Row(
                    //         children: [
                    //           //-- botão para fechar
                    //           Expanded(
                    //               child: ElevatedButton(
                    //                   onPressed: () {
                    //                     Navigator.of(context).pop();
                    //                   },
                    //                   child: const Text('Sair'))),
                    //           const SizedBox(
                    //             width: 15,
                    //           ),
                    //           Expanded(
                    //               child: ElevatedButton(
                    //                   onPressed: () async {
                    //                     if (_formKey.currentState!.validate()) {
                    //                       _formKey.currentState!.save();
                    //                       ItemServices itemServices =
                    //                           ItemServices();
                    //                       bool ok = await itemServices.addItem(
                    //                           item: item);
                    //                       if (ok) {
                    //                         ScaffoldMessenger.of(context)
                    //                             .showSnackBar(SnackBar(
                    //                           content: const Text(
                    //                               'Dados do item foram gravados com sucesso'),
                    //                           backgroundColor:
                    //                               Colors.amberAccent[400],
                    //                           duration:
                    //                               const Duration(seconds: 5),
                    //                         ));
                    //                         myToastDialog(
                    //                             msg:
                    //                                 'Item gravado com sucesso!!!');
                    //                       } else {
                    //                         ScaffoldMessenger.of(context)
                    //                             .showSnackBar(SnackBar(
                    //                           content: const Text(
                    //                               'Problemas ao gravar dados do item'),
                    //                           backgroundColor:
                    //                               Colors.amberAccent[400],
                    //                           duration:
                    //                               const Duration(seconds: 5),
                    //                         ));
                    //                         myToastDialog(
                    //                             msg:
                    //                                 'Item cadastrado com sucesso!!!');
                    //                       }
                    //                     }
                    //                   },
                    //                   child: const Text('Salvar'))),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    ));
  }

  Widget _listAquisicoes(
      BuildContext context, Aquisicao aquisicao, bool isSelected) {
    return Container(
      child: ListTile(
        title: Text(aquisicao.nome!),
      ),
    );
  }

  Widget _listGeneros(BuildContext context, Genero genero, bool isSelected) {
    return Container(
      child: ListTile(
        title: Text(genero.nome!),
      ),
    );
  }

  Widget _listCategorias(
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
