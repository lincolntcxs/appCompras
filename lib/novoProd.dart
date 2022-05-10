import 'package:reo4/home.dart';
import 'package:reo4/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NovoProd extends StatefulWidget {
  @override
  _NovoProd createState() => _NovoProd();
}

class _NovoProd extends State<NovoProd> {
  String _nome = '';
  String _marca = '';
  String _qtd = '';
  String _preco = '';

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
                  "Por favor preencha os campos.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    dica: "Nome",
                    onChanged: (value) {
                      _nome = value;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    dica: "Marca",
                    onChanged: (value) {
                      _marca = value;
                    },
                  ),
                  CustomInput(
                    dica: "Quantidade",
                    onChanged: (value) {
                      _qtd = value;
                    },
                  ),
                  CustomInput(
                    dica: "Preço",
                    onChanged: (value) {
                      _preco = value;
                    },
                  ),
                  TextButton(
                    child: Text("Criar novo produto"),
                    onPressed: () {
                      final databaseReference = FirebaseFirestore.instance
                          .collection("Produtos")
                          .add({
                        "Nome": _nome,
                        "Marca": _marca,
                        "Quantidade": _qtd,
                        "Preço": _preco
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaHome()),
                      );
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
