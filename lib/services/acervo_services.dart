// import 'package:commodities/helpers/responsive.dart';
// import 'package:commodities/helpers/validators.dart';
// import 'package:commodities/models/userLocal.dart';
// import 'package:commodities/pages/main/main_page.dart';
// import 'package:commodities/pages/login/signup_page.dart';
// import 'package:commodities/services/user_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final UserLocal _userLocal = UserLocal();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Scaffold(
//           body: StreamBuilder(
//               stream: FirebaseAuth.instance.authStateChanges(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return MainPage();
//                 } else {
//                   return SingleChildScrollView(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.only(left: 50, right: 50, top: 80),
//                       child: Center(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10.0),
//                               child: Image.asset(
//                                 'assets/images/commodity.jpg',
//                                 height:
//                                     Responsive.isMobile(context) ? 200 : 250,
//                                 width: Responsive.isMobile(context) ? 380 : 440,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             SizedBox(
//                               height: Responsive.isMobile(context) ? 20 : 40,
//                             ),
//                             Text(
//                               'Bem-vindo de volta!!!',
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 240, 119, 5),
//                                   fontSize:
//                                       Responsive.isMobile(context) ? 18 : 23,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Aplicativo para Commodities multi-funcional",
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 8, 45, 5),
//                                   fontSize:
//                                       Responsive.isMobile(context) ? 14 : 18,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             SizedBox(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               height: Responsive.isMobile(context) ? 50 : 60,
//                               child: TextFormField(
//                                 controller: _emailController,
//                                 decoration: InputDecoration(
//                                   label: Text(
//                                     'E-mail',
//                                     style: TextStyle(
//                                       fontSize: Responsive.isMobile(context)
//                                           ? 13
//                                           : 17,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(width: 1.2),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(width: 1.2),
//                                   ),
//                                 ),
//                                 validator: (email) {
//                                   //um validador deve ser chamando no Form
//                                   if (!emailValidator(email!)) {
//                                     return 'E-mail inválido!!!';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             SizedBox(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               height: Responsive.isMobile(context) ? 50 : 60,
//                               child: TextFormField(
//                                 controller: _passwordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                     label: Text(
//                                       "Senha",
//                                       style: TextStyle(
//                                         fontSize: Responsive.isMobile(context)
//                                             ? 13
//                                             : 17,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(width: 1.2),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(width: 1.2),
//                                     )),
//                               ),
//                             ),
//                             Container(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               padding: const EdgeInsets.only(
//                                 top: 5,
//                               ),
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 'Esqueceu a senha?',
//                                 style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize:
//                                       Responsive.isMobile(context) ? 12 : 15,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 40,
//                             ),
//                             SizedBox(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   UserServices userServices = UserServices();

//                                   _userLocal.email = _emailController.text;
//                                   _userLocal.password =
//                                       _passwordController.text;

//                                   bool ok = await userServices.signIn(
//                                     _userLocal.email.toString(),
//                                     _userLocal.password.toString(),
//                                   );
//                                   if (ok) {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => MainPage(),
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 1.8,
//                                   minimumSize: const Size.fromHeight(50),
//                                   shape: LinearBorder.bottom(),
//                                 ),
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                     color: Color.fromARGB(255, 1, 50, 3),
//                                     fontSize:
//                                         Responsive.isMobile(context) ? 14 : 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Responsive.isMobile(context) ? 20 : 30,
//                             ),
//                             SizedBox(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               child: Center(
//                                 child: Text(
//                                   'ou',
//                                   style: TextStyle(
//                                     color: Color.fromARGB(255, 1, 50, 3),
//                                     fontSize:
//                                         Responsive.isMobile(context) ? 14 : 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Responsive.isMobile(context) ? 20 : 30,
//                             ),
//                             SizedBox(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               child: OutlinedButton(
//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: const Size.fromHeight(50),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 onPressed: () {},
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/google.png',
//                                       height: 50,
//                                     ),
//                                     Text(
//                                       "Login com Google",
//                                       style: TextStyle(
//                                         color: Color.fromARGB(255, 1, 50, 3),
//                                         fontSize: Responsive.isMobile(context)
//                                             ? 14
//                                             : 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: Responsive.isMobile(context) ? 350 : 450,
//                               padding: const EdgeInsets.only(
//                                 top: 5,
//                               ),
//                               alignment: Alignment.centerRight,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   const Text('Ainda não tem conta?'),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => SignupPage(),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       'Registre-se aqui',
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: Responsive.isMobile(context)
//                                             ? 12
//                                             : 15,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               })),
//     );
//   }
// }
