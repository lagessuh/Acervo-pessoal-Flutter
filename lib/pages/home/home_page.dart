// import 'package:acervo/models/categoria.dart';
// import 'package:flutter/material.dart';
// import 'package:acervo/models/item.dart';
// import 'package:acervo/services/item_services.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   ItemServices itemServices = ItemServices();
//   List<Item> itens = [];
//   List<Categoria> categoriasSelecionadas = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchItensRecentes();
//   }

//   // Método para buscar os itens mais recentes
//   Future<void> _fetchItensRecentes() async {
//     final result =
//         await itemServices.getItensRecentes(); // Implementar no ItemServices
//     setState(() {
//       itens = result;
//     });
//   }

//   // Filtros baseados no texto e na categoria
//   Future<void> _filtrarItens() async {
//     final result = await itemServices.getItensFiltrados(
//       categoriasSelecionadas,
//       _searchController.text,
//     );
//     setState(() {
//       itens = result;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Estante Virtual'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: _filtrarItens,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Campo de busca por texto
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Buscar por Nome ou Autor',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Dropdown de seleção múltipla para categorias
//             DropdownSearch<Categoria>.multiSelection(
//               popupProps: const PopupPropsMultiSelection.dialog(
//                 showSearchBox: true,
//               ),
//               asyncItems: (String? filter) =>
//                   itemServices.getAllCategorias(), // Use a instância aqui
//               onChanged: (List<Categoria> categorias) {
//                 setState(() {
//                   categoriasSelecionadas = categorias;
//                 });
//               },
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: 'Filtrar por Categoria',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Lista ou Grid com os itens mais recentes
//             // Expanded(
//             //   child: itens.isEmpty
//             //       ? const Center(child: Text('Nenhum item encontrado.'))
//             //       : GridView.builder(
//             //           gridDelegate:
//             //               const SliverGridDelegateWithFixedCrossAxisCount(
//             //             crossAxisCount: 2,
//             //             crossAxisSpacing: 10,
//             //             mainAxisSpacing: 10,
//             //           ),
//             //           itemCount: itens.length,
//             //           itemBuilder: (context, index) {
//             //             final item = itens[index];
//             //             return Card(
//             //               child: Column(
//             //                 crossAxisAlignment: CrossAxisAlignment.start,
//             //                 children: [
//             //                   ListTile(
//             //                     title: Text(item.nome ?? 'Sem nome'),
//             //                     subtitle: Text(item.autor ?? 'Sem autor'),
//             //                   ),
//             //                   Text('Categoria: ${item.categoria?.nome ?? ''}'),
//             //                   Text(
//             //                       'Lançamento: ${item.dataLancamento?.toString() ?? ''}'),
//             //                 ],
//             //               ),
//             //             );
//             //           },
//             //         ),
//             // ),
//             SingleChildScrollView(
//               child: FutureBuilder<List<Item>>(
//                 future: itemServices.getItensRecentes(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Exibe um indicador de carregamento enquanto os dados estão sendo recuperados
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     // Exibe uma mensagem de erro se ocorrer algum problema ao recuperar os dados
//                     return const Center(child: Text('Erro ao carregar dados'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     // Exibe uma mensagem quando não há dados ou a lista de itens está vazia
//                     return const Center(child: Text('Nenhum item encontrado.'));
//                   } else {
//                     // Quando os dados são recebidos e não estão vazios, exibe a lista de itens
//                     final itens = snapshot.data!;
//                     return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemCount: itens.length,
//                       itemBuilder: (context, index) {
//                         final item = itens[index];
//                         return Card(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListTile(
//                                 title: Text(item.nome ?? 'Sem nome'),
//                                 subtitle: Text(item.autor ?? 'Sem autor'),
//                               ),
//                               Text('Categoria: ${item.categoria?.nome ?? ''}'),
//                               Text(
//                                   'Lançamento: ${item.dataLancamento?.toString() ?? ''}'),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:acervo/models/categoria.dart';
// import 'package:flutter/material.dart';
// import 'package:acervo/models/item.dart';
// import 'package:acervo/services/item_services.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   ItemServices itemServices = ItemServices();
//   List<Item> itens = [];
//   List<Categoria> categoriasSelecionadas = [];
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchItensRecentes();
//   }

//   // Método para buscar os itens mais recentes
//   Future<void> _fetchItensRecentes() async {
//     final result = await itemServices.getItensRecentes();
//     if (mounted) {
//       // Verifica se o widget ainda está montado
//       setState(() {
//         itens = result;
//       });
//     }
//   }

//   // Filtros baseados no texto e na categoria
//   Future<void> _filtrarItens() async {
//     final result = await itemServices.getItensFiltrados(
//       categoriasSelecionadas,
//       _searchController.text,
//     );
//     if (mounted) {
//       setState(() {
//         itens = result;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose(); // Libera o controlador de TextField
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Estante Virtual'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: _filtrarItens,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Campo de busca por texto
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Buscar por Nome ou Autor',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Dropdown de seleção múltipla para categorias
//             DropdownSearch<Categoria>.multiSelection(
//               popupProps: const PopupPropsMultiSelection.dialog(
//                 showSearchBox: true,
//               ),
//               asyncItems: (String? filter) =>
//                   itemServices.getAllCategorias(), // Use a instância aqui
//               onChanged: (List<Categoria> categorias) {
//                 setState(() {
//                   categoriasSelecionadas = categorias;
//                 });
//               },
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: 'Filtrar por Categoria',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Envolvendo o FutureBuilder dentro de Expanded para evitar problemas de layout
//             Expanded(
//               child: FutureBuilder<List<Item>>(
//                 future: itemServices.getItensRecentes(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return const Center(child: Text('Erro ao carregar dados'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('Nenhum item encontrado.'));
//                   } else {
//                     final itens = snapshot.data!;
//                     return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemCount: itens.length,
//                       itemBuilder: (context, index) {
//                         final item = itens[index];
//                         return Card(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListTile(
//                                 title: Text(item.nome ?? 'Sem nome'),
//                                 subtitle: Text(item.autor ?? 'Sem autor'),
//                               ),
//                               Text('Categoria: ${item.categoria?.nome ?? ''}'),
//                               Text(
//                                   'Lançamento: ${item.dataLancamento?.toString() ?? ''}'),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:acervo/models/categoria.dart';
// import 'package:flutter/material.dart';
// import 'package:acervo/models/item.dart';
// import 'package:acervo/services/item_services.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   ItemServices itemServices = ItemServices();
//   List<Item> itens = [];
//   List<Categoria> categoriasSelecionadas = [];
//   final TextEditingController _searchController = TextEditingController();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _fetchItensRecentes();
//   // }

//   @override
//   void initState() {
//     super.initState();
//     _futureItens = _getItensRecentes();
//   }

//   // Método para buscar os itens mais recentes
//   Future<void> _fetchItensRecentes() async {
//     final result =
//         await itemServices.getItensRecentes(); // Implementar no ItemServices
//     setState(() {
//       itens = result;
//     });
//   }

//   // Filtros baseados no texto e na categoria
//   Future<void> _filtrarItens() async {
//     final result = await itemServices.getItensFiltrados(
//       categoriasSelecionadas,
//       _searchController.text,
//     );
//     setState(() {
//       itens = result;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Estante Virtual'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: _filtrarItens,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // Campo de busca por texto
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Buscar por Nome ou Autor',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             // Dropdown de seleção múltipla para categorias
//             DropdownSearch<Categoria>.multiSelection(
//               popupProps: const PopupPropsMultiSelection.dialog(
//                 showSearchBox: true,
//               ),
//               asyncItems: (String? filter) =>
//                   itemServices.getAllCategorias(), // Use a instância aqui
//               onChanged: (List<Categoria> categorias) {
//                 setState(() {
//                   categoriasSelecionadas = categorias;
//                 });
//               },
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: 'Filtrar por Categoria',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             Expanded(
//               child: FutureBuilder<List<Item>>(
//                 future: itemServices.getItensRecentes(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Exibe um indicador de carregamento enquanto os dados estão sendo recuperados
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     // Exibe uma mensagem de erro se ocorrer algum problema ao recuperar os dados
//                     return const Center(child: Text('Erro ao carregar dados'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     // Exibe uma mensagem quando não há dados ou a lista de itens está vazia
//                     return const Center(child: Text('Nenhum item encontrado.'));
//                   } else {
//                     // Quando os dados são recebidos e não estão vazios, exibe os itens com ExpansionTile
//                     final itens = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: itens.length,
//                       itemBuilder: (context, index) {
//                         final item = itens[index];
//                         return ExpansionTile(
//                           title: Text(item.nome ?? 'Sem nome'),
//                           subtitle: Text(item.autor ?? 'Sem autor'),
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                       'Categoria: ${item.categoria?.nome ?? 'Sem categoria'}'),
//                                   Text(
//                                       'Lançamento: ${item.dataLancamento?.toString() ?? 'Sem data'}'),
//                                   Text(
//                                       'Edição: ${item.edicao ?? 'Sem edição'}'),
//                                   Text('Tipo: ${item.tipo ?? 'Sem tipo'}'),
//                                   Text(
//                                       'Avaliação: ${item.avaliacao?.toString() ?? 'Sem avaliação'}'),
//                                   Text(
//                                       'Aquisição: ${item.aquisicao ?? 'Sem aquisição'}'),
//                                   Text(
//                                       'Data de Cadastro: ${item.data?.toString() ?? 'Sem data'}'),
//                                 ],
//                               ),
//                             ),
//                             const Divider(),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:acervo/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:acervo/models/item.dart';
import 'package:acervo/services/item_services.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemServices itemServices = ItemServices();
  List<Item> itens = [];
  List<Categoria> categoriasSelecionadas = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _fetchItensRecentes();
  }

  @override
  void dispose() {
    _isMounted = false;
    _searchController.dispose();
    super.dispose();
  }

  // Método para buscar os itens mais recentes
  Future<void> _fetchItensRecentes() async {
    try {
      final result = await itemServices.getItensRecentes();
      if (_isMounted) {
        setState(() {
          itens = result;
        });
      }
    } catch (e) {
      // Trate o erro se necessário
      print('Erro ao buscar itens: $e');
    }
  }

  // Filtros baseados no texto e na categoria
  Future<void> _filtrarItens() async {
    try {
      final result = await itemServices.getItensFiltrados(
        categoriasSelecionadas,
        _searchController.text,
      );
      if (_isMounted) {
        setState(() {
          itens = result;
        });
      }
    } catch (e) {
      // Trate o erro se necessário
      print('Erro ao filtrar itens: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estante Virtual'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _filtrarItens,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Campo de busca por texto
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar por Nome ou Autor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Dropdown de seleção múltipla para categorias
            DropdownSearch<Categoria>.multiSelection(
              popupProps: const PopupPropsMultiSelection.dialog(
                showSearchBox: true,
              ),
              asyncItems: (String? filter) => itemServices.getAllCategorias(),
              onChanged: (List<Categoria> categorias) {
                setState(() {
                  categoriasSelecionadas = categorias;
                });
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Filtrar por Categoria',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Usar Expanded para limitar a altura do ListView
            Expanded(
              child: FutureBuilder<List<Item>>(
                future: itemServices.getItensRecentes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Exibe um indicador de carregamento enquanto os dados estão sendo recuperados
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Exibe uma mensagem de erro se ocorrer algum problema ao recuperar os dados
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Exibe uma mensagem quando não há dados ou a lista de itens está vazia
                    return const Center(child: Text('Nenhum item encontrado.'));
                  } else {
                    // Quando os dados são recebidos e não estão vazios, exibe os itens com ExpansionTile
                    final itens = snapshot.data!;
                    return ListView.builder(
                      itemCount: itens.length,
                      itemBuilder: (context, index) {
                        final item = itens[index];
                        return ExpansionTile(
                          title: Text(item.nome ?? 'Sem nome'),
                          subtitle: Text(item.autor ?? 'Sem autor'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Categoria: ${item.categoria?.nome ?? 'Sem categoria'}'),
                                  Text(
                                      'Lançamento: ${item.dataLancamento ?? 'Sem data'}'),
                                  Text(
                                      'Edição: ${item.edicao ?? 'Sem edição'}'),
                                  Text('Tipo: ${item.tipo ?? 'Sem tipo'}'),
                                  Text(
                                      'Avaliação: ${item.avaliacao?.toString() ?? 'Sem avaliação'}'),
                                  Text(
                                      'Aquisição: ${item.aquisicao ?? 'Sem aquisição'}'),
                                  Text(
                                      'Data de Cadastro: ${item.data ?? 'Sem data'}'),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
