import 'package:acervo/commons/appbar_icons.dart';
import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/login/login_page.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';

class AppBarUI extends StatelessWidget {
  const AppBarUI({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 101, 85, 143),
      elevation: 1,
      title: Row(
        children: [
          Text(
            'Gerenciamento de Acervo',
            style: TextStyle(
                fontFamily: 'Aptos',
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isMobile(context) ? 20 : 24,
                color: Colors.white),
          ),
          // SvgPicture.asset(),
          const Spacer(),
          AppBarIcons(
            icon: Icons.notifications_active_outlined,
            onTap: () {},
          ),
          AppBarIcons(
            icon: Icons.logout_rounded,
            onTap: () async {
              UserServices userServices = UserServices();

              bool ok = await userServices.logOut();
              if (ok) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      actions: [
        PopupMenuButton<Text>(
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                child: Text('Primeiro'),
              ),
              const PopupMenuItem(
                child: Text('Segundo'),
              ),
              const PopupMenuItem(
                child: Text('Terceiro'),
              ),
            ];
          },
        )
      ],
    );
  }
}
