import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/acervo/acervo_list_search_page.dart';
import 'package:acervo/pages/aquisicao/aquisicao_list_page.dart';
import 'package:acervo/pages/categorias/categoria_list_page.dart';
import 'package:acervo/pages/genero/genero_list_page.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acervo/commons/widgets/my_card_adm/my_card_adm.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var sizeScreen;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    debugPrint('Largura da Tela $sizeScreen');
    setState(() {
      sizeScreen = MediaQuery.of(context).size.width;
    });
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
                      : Responsive.isLaptop(context)
                          ? height * 0.15
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
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: height * 0.9,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyCardAdm(
                      imageCard: 'assets/images/acervo.png',
                      nameCard: 'Item',
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AcervoListSearchPage() //AcervoListPage(),
                              ),
                        );
                      },
                    ),
                    MyCardAdm(
                      imageCard: 'assets/images/acervo.jpg',
                      nameCard: 'Gênero',
                      height: height,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GeneroListPage(),
                        ));
                      },
                    ),
                    MyCardAdm(
                      imageCard: 'assets/images/acervo.png',
                      nameCard: 'Categoria',
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriaListPage(),
                          ),
                        );
                      },
                    ),
                    MyCardAdm(
                      imageCard: 'assets/images/acervo.png',
                      nameCard: 'Local de Aquisção',
                      height: height,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AquisicaoListPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
