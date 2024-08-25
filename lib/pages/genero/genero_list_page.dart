import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/models/genero.dart';
import 'package:acervo/pages/genero/genero_add_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/services/genero_services.dart';
import 'package:flutter/material.dart';

class GeneroListPage extends StatefulWidget {
  const GeneroListPage({super.key});

  @override
  State<GeneroListPage> createState() => _GeneroListPageState();
}

class _GeneroListPageState extends State<GeneroListPage> {
  final Genero genero = Genero();

  final GeneroServices generoServices = GeneroServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gênero'),
      ),
      body: StreamBuilder(
          stream: generoServices.getGeneros(),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Gênero:'),
                                      Text(
                                        '${ds['nome']}',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 7, 48, 8),
                                          fontSize: Responsive.isExtraLarge(
                                                  context)
                                              ? 21.0
                                              : Responsive.isDesktop(context)
                                                  ? 19
                                                  : Responsive.isLaptop(context)
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
                                        generoServices.deleteGenero(ds.id);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        genero.id = ds.id;
                                        genero.nome = ds['nome'];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const GeneroAddPage(),
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
