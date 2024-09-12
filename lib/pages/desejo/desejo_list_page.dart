import 'package:acervo/services/desejo_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/pages/desejo/desejo_add_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DesejoListPage extends StatelessWidget {
  const DesejoListPage({super.key});
  @override
  Widget build(BuildContext context) {
    DesejoServices desejoServices = DesejoServices();
    final dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Desejos',
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
            stream: desejoServices.getDesejos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                        ds['date'].millisecondsSinceEpoch);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: Card(
                        color: const Color.fromARGB(255, 238, 246, 237),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Categoria: ${ds['categoria']['nome']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 101, 85, 143),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DesejoAddPage()),
            );
          },
          child: const Text(
            '+',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
    );
  }
}
