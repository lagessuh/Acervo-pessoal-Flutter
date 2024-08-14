import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/main/main_page.dart';
import 'package:acervo/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acervo/pages/login/signup_page.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:acervo/helpers/validators.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserLocal _userLocal = UserLocal();

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(214, 198, 255, 84),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 80),
                  // child: SingleChildScrollView(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Color(0xFF65558F),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 108,
                                height: 108,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/acervo.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // Espaço entre a imagem e o texto
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'GERENCIAMENTO DE\nACERVO PESSOAL',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFD9D9D9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'E-mail',
                            ),
                            validator: (email) {
                              //um validador deve ser chamando no Form
                              if (!emailValidator(email!)) {
                                return 'E-mail inválido!!!';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFD9D9D9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Senha',
                            ),
                            obscureText: true,
                            controller: _passwordController,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: Responsive.isMobile(context) ? 350 : 450,
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 350 : 450,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserServices userServices = UserServices();

                              _userLocal.email = _emailController.text;
                              _userLocal.password = _passwordController.text;

                              bool ok = await userServices.signIn(
                                _userLocal.email.toString(),
                                _userLocal.password.toString(),
                              );
                              if (ok) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF65558F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              //minimumSize: const Size(300, 50),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 20 : 30,
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 350 : 450,
                          child: Center(
                            child: Text(
                              'ou',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 1, 50, 3),
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        //const Text('OU'),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 20 : 30,
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 350 : 450,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF65558F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              minimumSize: const Size.fromHeight(50),
                              //minimumSize: const Size(300, 50),
                              //maximumSize: const Size(300, 50)
                              //padding: const EdgeInsets.symmetric(
                              //horizontal: 82, vertical: 16),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 20,
                                ),
                                const Text(
                                  '  Login com Google',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: Responsive.isMobile(context) ? 350 : 450,
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Ainda não tem conta?'),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Registre-se aqui',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        Responsive.isMobile(context) ? 12 : 15,
                                  ),
                                ),
                                //   ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => const SignupPage(),
                                //         ),
                                //       );
                                //     },
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: const Color(0xFF65558F),
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(100),
                                //       ),
                                //       minimumSize: const Size(300, 50),
                                //       //padding: const EdgeInsets.symmetric(
                                //       //orizontal: 82, vertical: 16),
                                //     ),
                                //     child: const Text(
                                //       'Registre-se',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 16,
                                //         fontFamily: 'Roboto',
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ),
                                // ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
