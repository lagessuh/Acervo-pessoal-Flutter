//import 'package:flutter/foundation.dart';
import 'package:acervo/commons/appbar_ui.dart';
import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/acervo/admin_page.dart';
import 'package:acervo/pages/home/home_page.dart';
import 'package:acervo/pages/desejo/desejo_list_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Responsive.isMobile(context) ? 50 : 60,
              Responsive.isMobile(context) ? 50 : 60),
          child: const AppBarUI()),
      body: [
        const HomePage(),
        const AdminPage(),
        const DesejoListPage(),
        const HomePage(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(172, 214, 198, 255),
        height: 70,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Acervo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Lista de Desejos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
