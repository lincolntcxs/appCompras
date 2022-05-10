import 'package:reo4/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastro createState() => _TelaCadastro();
}

class _TelaCadastro extends State<TelaCadastro> {
  bool _carregando = false;
  String _email = "";
  String _senha = "";
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
                style: TextButton.styleFrom(primary: Colors.orange),
                child: Text("Fechar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Senha fraca.';
      } else if (e.code == 'email-already-in-use') {
        return 'Email já existe.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _carregando = true;
    });
    String _feedback = await _createAccount();
    if (_feedback != null) {
      _alertDialogBuilder(_feedback);
      setState(() {
        _carregando = false;
      });
    } else {
      Navigator.pop(context);
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
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Crie sua conta",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    dica: "Email",
                    onChanged: (value) {
                      _email = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    dica: "Senha",
                    onChanged: (value) {
                      _senha = value;
                    },
                    focusNode: _passwordFocusNode,
                    campoSenha: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  TextButton(
                    child: Text("Criar conta"),
                    style: TextButton.styleFrom(primary: Colors.orange),
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
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
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
