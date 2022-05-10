import 'package:reo4/cadastrar.dart';
import 'package:reo4/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLogin createState() => _TelaLogin();
}

class _TelaLogin extends State<TelaLogin> {
  bool _carregandoLogin = false;
  String _emailLogin = "";
  String _senhaLogin = "";
  FocusNode _passwordFocusNode;

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                child: Text("Fechar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailLogin, password: _senhaLogin);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _carregandoLogin = true;
    });

    String _loginFeedback = await _loginAccount();
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);
      setState(() {
        _carregandoLogin = false;
      });
    }
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: AppBar(
                  title: Text('Cantinho Mineiro'),
                  backgroundColor: Colors.orangeAccent,
                  centerTitle: true,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    dica: "Email",
                    onChanged: (value) {
                      _emailLogin = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    dica: "Senha",
                    onChanged: (value) {
                      _senhaLogin = value;
                    },
                    focusNode: _passwordFocusNode,
                    campoSenha: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.orange),
                    child: Text("Entrar"),
                    onPressed: () {
                      _submitForm();
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.orange),
                  child: Text("Criar nova conta"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaCadastro()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
