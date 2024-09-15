import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/main/main_page.dart';
import 'package:acervo/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acervo/pages/login/signup_page.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:acervo/helpers/validators.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserLocal _userLocal = UserLocal();
  late Box box;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box = await Hive.openBox('user');
    getDataBox();
  }

  void getDataBox() async {
    if (box.get('remember').toString() == 'true') {
      if (box.get('email') != null && mounted) {
        setState(() {
          _emailController.text = box.get('email');
          isChecked = true;
        });
      }
      if (box.get('password') != null && mounted) {
        setState(() {
          _passwordController.text = box.get('password');
          isChecked = true;
        });
      }
    }
  }

// Delete info from people box
  _deleteInfo(int index) {
    box.deleteAt(index);
    print('Item deleted from box at index: $index');
  }

  @override
  Widget build(BuildContext context) {
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
                child: Center(
                  child: Consumer<UserServices>(
                    builder: (_, userServices, __) {
                      return Column(
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
                                      image: AssetImage(
                                          'assets/images/acervo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                                if (!emailValidator(email!)) {
                                  return 'E-mail inválido!!!';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo senha deve ser informado';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            width: Responsive.isMobile(context) ? 350 : 450,
                            child: ElevatedButton(
                              onPressed: () {
                                userServices.signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    onSuccess: () {
                                      saveLoginHive();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainPage(),
                                        ),
                                      );
                                    },
                                    onFail: (String error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Falha ao entrar: $error',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                              },
                              //);

                              // _userLocal.email = _emailController.text;
                              // _userLocal.password = _passwordController.text;

                              // bool ok = await userServices.signIn(
                              //   _userLocal.email.toString(),
                              //   _userLocal.password.toString(),
                              // );
                              // if (ok) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const MainPage(),
                              //     ),
                              //   );
                              // }
                              //},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF65558F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
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
                          Container(
                            width: Responsive.isMobile(context) ? 350 : 450,
                            padding: const EdgeInsets.only(top: 5),
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
                          const SizedBox(height: 16),
                          Container(
                            width: Responsive.isMobile(context) ? 350 : 450,
                            padding: const EdgeInsets.only(top: 5),
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Ainda não possui uma conta?'),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Registre-se aqui',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.isMobile(context)
                                          ? 12
                                          : 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    ));
  }

  void saveLoginHive() async {
    if (isChecked) {
      await box.put('email', _emailController.text);
      await box.put('password', _passwordController.text);
      await box.put('remember', isChecked);
    } else {
      await box.delete('email');
      await box.delete('password');
      await box.put('remember', false);
    }
  }
}
