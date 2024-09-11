import 'package:acervo/commons/widgets/my_card_adm/my_card_adm.dart';
import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/item/item_list_page.dart';
//import 'package:acervo/pages/acervo/acervo_list_search_page.dart';
import 'package:acervo/pages/aquisicao/aquisicao_list_page.dart';
import 'package:acervo/pages/categoria/categoria_list_page.dart';
import 'package:acervo/pages/genero/genero_list_page.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Ajusta a largura dos cards para caberem duas colunas
    var cardWidth = (width * 0.4); // Ajuste conforme necessário
    var cardHeight = cardWidth; // Mantém altura igual à largura

    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(172, 214, 198, 255),
        child: Column(
          children: [
            SizedBox(
              height: Responsive.isDesktop(context)
                  ? height * 0.15
                  : Responsive.isLaptop(context)
                      ? height * 0.18
                      : Responsive.isMobile(context)
                          ? height * 0.13
                          : height * 0.13,
              width: Responsive.isDesktop(context)
                  ? width * .9
                  : Responsive.isTablet(context)
                      ? width * .8
                      : Responsive.isLaptop(context)
                          ? width * 0.75
                          : width * 0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Administração do Acervo",
                      style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black,
                          fontSize: Responsive.isDesktop(context)
                              ? 30
                              : Responsive.isLaptop(context)
                                  ? 28
                                  : Responsive.isTablet(context)
                                      ? 26
                                      : 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: Responsive.isDesktop(context)
                          ? 150
                          : Responsive.isLaptop(context)
                              ? 120
                              : Responsive.isTablet(context)
                                  ? 100
                                  : 80,
                      width: Responsive.isDesktop(context)
                          ? 75
                          : Responsive.isLaptop(context)
                              ? 60
                              : Responsive.isTablet(context)
                                  ? 50
                                  : 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/acervo.png'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Primeira linha de cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: MyCardAdm(
                              imageCard: 'assets/images/item.png',
                              nameCard: 'Item',
                              height: cardHeight,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ItemListPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: MyCardAdm(
                              imageCard: 'assets/images/teatro.png',
                              nameCard: 'Gênero',
                              height: cardHeight,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const GeneroListPage(),
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Segunda linha de cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: MyCardAdm(
                              imageCard: 'assets/images/entretenimento.png',
                              nameCard: 'Categoria',
                              height: cardHeight,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoriaListPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: MyCardAdm(
                              imageCard: 'assets/images/placeholder.png',
                              nameCard: 'Local de Aquisição',
                              height: cardHeight,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AquisicaoListPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
