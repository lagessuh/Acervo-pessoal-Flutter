import 'package:acervo/models/item.dart';
import 'package:acervo/services/item_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:acervo/services/user_services.dart';
import 'package:acervo/services/aquisicao_services.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:acervo/services/genero_services.dart';
import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/genero.dart';

class ItemEditPage extends StatefulWidget {
  const ItemEditPage({super.key, this.item});
  final Item? item;
  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  AquisicaoServices aquisicaoServices = AquisicaoServices();
  GeneroServices generoServices = GeneroServices();
  CategoriaServices categoriaServices = CategoriaServices();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _edicaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _dataLancamentoController =
      TextEditingController();
  //final TextEditingController _typeController = TextEditingController();

  List<String> tiposDeItem = ['Físico', 'Digital'];
  List<String> avaliacoes = [
    'Excelente',
    'Bom',
    'Regular',
  ];

  String? tipoSelecionado;
  String? avaliacaoSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.nome ?? '';
      _autorController.text = widget.item!.autor ?? '';
      _edicaoController.text = widget.item!.edicao ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Item? item;
    _nameController.text = widget.item!.nome!;
    _autorController.text = widget.item!.autor!;
    _edicaoController.text = widget.item!.edicao!;
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'Editando categoria',
              style: TextStyle(
                fontSize: 30,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'id: ${item!.id}',
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
              height: 15,
            ),
            TextField(
              controller: _autorController,
              decoration: const InputDecoration(
                label: Text('Autor:'),
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
              height: 15,
            ),
            TextField(
              controller: _edicaoController,
              decoration: const InputDecoration(
                label: Text('Edição:'),
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
              height: 15,
            ),
            //colocar um dropdown com o tipo do item, físico ou digital
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  labelText: "Tipo do Item", border: OutlineInputBorder()),
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
                  item.tipo = value; // Atualiza o valor de avaliação no item
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
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
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
              asyncItems: (String? filter) async {
                // Certifique-se de que getAllGenerosItem retorna uma lista de Genero
                List<Genero> generos =
                    await generoServices.getAllGenerosItem(filter ?? '');
                return generos;
              },
              compareFn: (item, sItem) => item.id == sItem.id,
              popupProps: PopupPropsMultiSelection.menu(
                itemBuilder: _listGeneros,
                showSearchBox: true,
                showSelectedItems: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Gênero',
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
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
              onSaved: (Genero? value) {
                if (value != null) {
                  item.genero = value;
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'O gênero deve ser preenchido!!!';
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
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
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
              decoration: const InputDecoration(hintText: 'Data de Cadastro'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 17, 1),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dataLancamentoController,
              decoration: const InputDecoration(hintText: 'Data de Lançamento'),
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
                      if (widget.item != null) {
                        widget.item!.nome = _nameController.text;
                        widget.item!.autor = _autorController.text;
                        widget.item!.edicao = _edicaoController.text;

                        ItemServices itemServices = ItemServices();
                        itemServices
                            .updateItem(widget.item!)
                            .then((value) => Navigator.pop(context));
                      }
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
