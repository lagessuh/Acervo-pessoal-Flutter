import 'package:acervo/helpers/responsive.dart';
import 'package:acervo/pages/profile/profile_edit_page.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
          child: Consumer<UserServices>(
            builder: (context, userServices, child) {
              // final user = userServices.getUser;
              // if (user == null) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              return Column(
                children: [
                  Text(
                    'Perfil do Usuário',
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 25 : 20,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins'),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 223, 223, 223),
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                    child: Card(
                      elevation: .5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 20),
                            child: Row(
                              children: [
                                // SizedBox(
                                //   height: 80,
                                //   width: 80,
                                //   child: ClipOval(
                                //     child: Image.network(
                                //       userServices.userLocal!.image ?? '',
                                //       fit: BoxFit.fill,
                                //       errorBuilder: (BuildContext context,
                                //           Object exception,
                                //           StackTrace? stackTrace) {
                                //         return Icon(Iconsax.people,
                                //             color: Colors.grey.shade400);
                                //       },
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // context.read<UserServices>().getUser!.userName!,
                                        '${userServices.getUser!.userName}',
                                        // '${user.userName}',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isDesktop(context)
                                                    ? 20
                                                    : 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                      Text(
                                        '${userServices.getUser!.email}',
                                        // '${user.email}',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isDesktop(context)
                                                    ? 14
                                                    : 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins'),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade100),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileEditPage(),
                                  ));
                                },
                                child: Row(
                                  children: [
                                    const Icon(Iconsax.personalcard),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dados pessoais',
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.isDesktop(context)
                                                      ? 14
                                                      : 12,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'Poppins'),
                                        ),
                                        Text(
                                          'Informações pessoais',
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.isDesktop(context)
                                                      ? 14
                                                      : 12,
                                              fontWeight: FontWeight.w200,
                                              fontFamily: 'Poppins'),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 223, 223, 223),
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                    child: Card(
                      elevation: .5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileEditPage()));
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.account_box_rounded),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dados da conta',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isDesktop(context)
                                                    ? 14
                                                    : 12,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Poppins'),
                                      ),
                                      Text(
                                        'Alterar senha, bloquear conta',
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isDesktop(context)
                                                    ? 14
                                                    : 12,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: 'Poppins'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
