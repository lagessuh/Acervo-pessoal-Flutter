import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/aquisicao.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/models/genero.dart';
import 'package:acervo/models/item.dart';
import 'package:acervo/pages/item/item_add_page.dart';
import 'package:acervo/pages/item/item_edit_page.dart';
import 'package:acervo/services/item_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  Item item = Item();
  ItemServices itemServices = ItemServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(214, 198, 255, 84),
      appBar: AppBar(
        title: const Text(
          'Itens',
          style: TextStyle(
              fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(172, 214, 198, 255),
            border: const Border()),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: StreamBuilder(
            stream: itemServices.getItem(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: Responsive.isExtraLarge(context)
                            ? 300.0
                            : Responsive.isDesktop(context)
                                ? 200
                                : Responsive.isLaptop(context)
                                    ? 90
                                    : Responsive.isTablet(context)
                                        ? 50
                                        : 20,
                        right: Responsive.isExtraLarge(context)
                            ? 300.0
                            : Responsive.isDesktop(context)
                                ? 200
                                : Responsive.isLaptop(context)
                                    ? 90
                                    : Responsive.isTablet(context)
                                        ? 50
                                        : 20,
                        bottom: 10,
                      ),
                      child: Card(
                        //color: const Color.fromARGB(255, 238, 246, 237),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 280,
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Nome do Item: ${ds['nome']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Nome do Autor: ${ds['autor']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Edição: ${ds['edicao']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Tipo: ${ds['tipo']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Avaliação: ${ds['avaliacao']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              //'Local de Aquisição: ${ds['aquisicao']['nome']}',
                                              'Local de Aquisição: ${ds['aquisicao'] != null ? ds['aquisicao']['nome'] ?? 'Sem nome' : 'Local não definido'}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Categoria: ${ds['categoria'] != null ? ds['categoria']['nome'] ?? 'Sem nome' : 'Categoria não definida'}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              //'Gênero: ${ds['genero']['nome']}',
                                              'Gênero: ${ds['genero'] != null ? ds['genero']['nome'] ?? 'Sem nome' : 'Gênero não definido'}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Data de Lançamento: ${ds['dataLancamento']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Data de Cadastro: ${ds['data']}',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 7, 48, 8),
                                                fontSize: Responsive
                                                        .isExtraLarge(context)
                                                    ? 21.0
                                                    : Responsive.isDesktop(
                                                            context)
                                                        ? 19
                                                        : Responsive.isLaptop(
                                                                context)
                                                            ? 17
                                                            : Responsive
                                                                    .isTablet(
                                                                        context)
                                                                ? 15
                                                                : 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          itemServices.deleteItem(ds.id);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          item.id = ds.id;
                                          item.nome = ds['nome'];
                                          item.autor = ds['autor'];
                                          item.edicao = ds['edicao'];
                                          item.tipo = ds['tipo'];
                                          item.avaliacao = ds['avaliacao'];
                                          // item.aquisicao = ds['aquisicao'];
                                          item.aquisicao = Aquisicao.fromMap(
                                              ds['aquisicao']);
                                          // item.avaliacao = ds['avaliacao'];
                                          item.categoria = Categoria.fromMap(
                                              ds['categoria']);
                                          // item.genero = ds['genero'];
                                          item.genero =
                                              Genero.fromMap(ds['genero']);
                                          // item.categoria = ds['categoria'];
                                          item.dataLancamento =
                                              ds['dataLancamento'];
                                          item.data = ds['data'];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemEditPage(
                                                item: item,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.orange,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 101, 85, 143),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ItemAddPage()),
            );
          },
          child: const Text(
            '+',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }
}
