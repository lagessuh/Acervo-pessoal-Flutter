import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
          child: Text(
        'perfil do usuário',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color.fromARGB(255, 1, 39, 3),
        ),
      )),
    );
  }
}
