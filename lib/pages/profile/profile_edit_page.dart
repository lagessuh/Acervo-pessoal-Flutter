import 'package:acervo/commons/widgets/my_textformfield.dart';
import 'package:acervo/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Consumer<UserServices>(
              builder: (context, userServices, _) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Editar Perfil do Usuário",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // ClipOval(
                      //   child: Image(
                      //     image: NetworkImage(userServices.userLocal!.image!),
                      //     height: 70,
                      //     width: 70,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextFormField(
                        initialValue: userServices.userLocal!.userName,
                        labelText: 'Nome do usuário:',
                        textType: TextInputType.text,
                        onChanged: (value) =>
                            userServices.userLocal!.userName = value,
                        onSaved: (value) =>
                            userServices.userLocal!.userName = value,
                        validator: (value) {
                          if (value == null) {
                            return 'O campo nome deve ser preenchido!!!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        initialValue: userServices.userLocal!.email,
                        enabled: false,
                        labelText: 'Email:',
                        textType: TextInputType.text,
                        onChanged: (value) {},
                        onSaved: (value) =>
                            userServices.userLocal!.email = value,
                        validator: (value) {
                          if (value == null) {
                            return 'O campo email deve ser preenchido!!!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // MyTextFormField(
                      //   initialValue: userServices.userLocal!.phone,
                      //   labelText: 'Telefone:',
                      //   textType: TextInputType.text,
                      //   onChanged: (value) =>
                      //       userServices.userLocal!.phone = value,
                      //   onSaved: (value) =>
                      //       userServices.userLocal!.phone = value,
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'O campo telefone deve ser preenchido!!!';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Voltar')),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  // userLocal.id = userServices.userLocal!.id;
                                  // userLocal.image = userServices.userLocal!.image;
                                  userServices.updateData(
                                      userLocal: userServices.userLocal,
                                      onFail: (erro) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Falha ao entrar: $erro',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Registro realizado com sucesso',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        // sendEmail(context);

                                        Navigator.pop(context);
                                      });
                                }
                              },
                              autofocus: true,
                              style: OutlinedButton.styleFrom(
                                  elevation: 1, shape: LinearBorder.bottom()),
                              child: const Text('Salvar'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
