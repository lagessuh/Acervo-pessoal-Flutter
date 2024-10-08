import 'package:acervo/commons/widgets/my_textformfield.dart';
import 'package:acervo/helpers/validators.dart';
import 'package:acervo/models/userlocal.dart';
import 'package:acervo/pages/login/login_page.dart';
import 'package:acervo/services/user_services.dart';
//import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserLocal userLocal = UserLocal();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController userNameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(214, 198, 255, 84),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
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
                            image: AssetImage('assets/images/acervo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 20), // Espaço entre a imagem e o texto
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
                //MyTextFormField(userNameController: userNameController),
                MyTextFormField(
                  onSaved: (value) => userLocal.userName = value,
                  onChanged: (value) {},
                  labelText: 'Nome do Usuário',
                  textType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo usuário deve ser preenchido';
                    }

                    return null;
                  },
                ),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                // child: TextFormField(
                //   controller: userNameController,
                //   decoration: const InputDecoration.collapsed(hintText: 'Nome'),
                // ),
                //),
                const SizedBox(height: 16),
                MyTextFormField(
                  onChanged: (value) {},
                  onSaved: (value) => userLocal.email = value,
                  labelText: 'E-mail',
                  textType: TextInputType.emailAddress,
                  validator: (email) {
                    //um validador deve ser chamando no Form
                    if (!emailValidator(email!)) {
                      return 'E-mail inválido!!!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                MyTextFormField(
                  onChanged: (value) {},
                  onSaved: (value) => _password = value.toString(),
                  labelText: 'Senha',
                  textType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo senha deve ser informado';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //-- populando objeto (classe de dados)
                      _formKey.currentState!.save();
                      //criando instância da classe UserServices
                      UserServices userServices = UserServices();

                      //utilizando a instância da classe UserServices
                      userServices.signUp(
                        userLocal: userLocal,
                        password: _password,
                        onFail: (erro) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Falha ao entrar: $erro',
                                style: const TextStyle(fontSize: 14),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        onSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Registro realizado com sucesso',
                                style: TextStyle(fontSize: 14),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF65558F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'OU',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF65558F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Já Possuo uma Conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
