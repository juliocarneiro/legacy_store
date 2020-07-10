import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:legacy_store/helpers/validators.dart';
import 'package:legacy_store/models/user.dart';
import 'package:legacy_store/models/user_manager.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Entrar'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              textColor: Colors.white,
              child: const Text(
                'CRIAR CONTA',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'E-MAIL'),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        controller: emailController,
                        enabled: !userManager.loading,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'SENHA'),
                        obscureText: true,
                        autocorrect: false,
                        controller: passController,
                        enabled: !userManager.loading,
                        validator: (pass) {
                          if (pass.isEmpty || pass.length < 6) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          child: const Text('ESQUECI MINHA SENHA'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    context.read<UserManager>().signIn(
                                        user: User(
                                          email: emailController.text,
                                          password: passController.text,
                                        ),
                                        onFail: (e) {
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text('$e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        },
                                        onSuccess: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                },
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          child: userManager.loading
                              ? SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ))
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
