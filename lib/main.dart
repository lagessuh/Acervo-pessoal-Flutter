// import 'package:acervo/pages/main/main_page.dart';
// import 'package:acervo/services/user_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:acervo/pages/login/login_page.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   var options = const FirebaseOptions(
//       apiKey: "AIzaSyAvAJnwo6dgBRV6T4qz_SDGpKKr6WLlY_0",
//       authDomain: "acervo-54ddd.firebaseapp.com",
//       projectId: "acervo-54ddd",
//       storageBucket: "acervo-54ddd.appspot.com",
//       messagingSenderId: "984510798865",
//       appId: "1:984510798865:web:bfef19f277b01f46cce5b0",
//       measurementId: "G-Y90VH810W0");

//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();

//   if (kIsWeb) {
//     await Firebase.initializeApp(options: options);
//   } else {
//     await Firebase.initializeApp();
//   }
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
// // Apps theme data
//   final appTheme = ThemeData(
//     useMaterial3: true,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//     ),
//     //extensions: [AppColorTheme2()],
//   );
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => UserServices(),
//         ),
//       ],
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             colorScheme:
//                 ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 39, 1)),
//             useMaterial3: true,
//           ),
//           home: const MyAccess()),
//     );
//   }
// }

// class MyAccess extends StatelessWidget {
//   const MyAccess({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (BuildContext context, snapshot) {
//             if (snapshot.hasData) {
//               return const MainPage();
//             } else {
//               return const LoginPage();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
// //         useMaterial3: true,
// //       ),
// //       home: LoginPage(),
// //     );
// //   }
// // }

import 'package:acervo/pages/main/main_page.dart';
import 'package:acervo/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:acervo/pages/login/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var options = const FirebaseOptions(
    apiKey: "AIzaSyAvAJnwo6dgBRV6T4qz_SDGpKKr6WLlY_0",
    authDomain: "acervo-54ddd.firebaseapp.com",
    projectId: "acervo-54ddd",
    storageBucket: "acervo-54ddd.appspot.com",
    messagingSenderId: "984510798865",
    appId: "1:984510798865:web:bfef19f277b01f46cce5b0",
    measurementId: "G-Y90VH810W0",
  );

  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme.copyWith(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 39, 1)),
        ),
        home: const MyAccess(),
      ),
    );
  }
}

class MyAccess extends StatelessWidget {
  const MyAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
