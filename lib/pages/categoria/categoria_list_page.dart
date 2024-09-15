import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/categoria.dart';
import 'package:acervo/pages/categoria/categoria_add_page.dart';
import 'package:acervo/pages/categoria/categoria_edit_page.dart';
import 'package:acervo/services/categoria_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriaListPage extends StatefulWidget {
  const CategoriaListPage({super.key});

  @override
  State<CategoriaListPage> createState() => _CategoriaListPageState();
}

class _CategoriaListPageState extends State<CategoriaListPage> {
  final Categoria categoria = Categoria();

  final CategoriaServices categoriaServices = CategoriaServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(214, 198, 255, 84),
      appBar: AppBar(
        title: const Text(
          'Categoria',
          style: TextStyle(
              fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
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
              stream: categoriaServices.getCategorias(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(), // or the data you want to show while loading...
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 85,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Categoria:'),
                                          Text(
                                            '${ds['nome']}',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 7, 48, 8),
                                              fontSize: Responsive.isExtraLarge(
                                                      context)
                                                  ? 21.0
                                                  : Responsive.isDesktop(
                                                          context)
                                                      ? 19
                                                      : Responsive.isLaptop(
                                                              context)
                                                          ? 17
                                                          : Responsive.isTablet(
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
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            categoriaServices
                                                .deleteCategoria(ds.id);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            categoria.id = ds.id;
                                            categoria.nome = ds['nome'];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoriaEditPage(
                                                  categoria: categoria,
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
              })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 101, 85, 143),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CategoriaAddPage(),
            ),
          );
        },
        child: const Text(
          '+',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
