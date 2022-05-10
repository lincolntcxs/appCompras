import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reo4/pagCarrin.dart';

class PagProd extends StatefulWidget {
  final String productId;
  PagProd({this.productId});

  @override
  _PagProdState createState() => _PagProdState();
}

class _PagProdState extends State<PagProd> {
  final CollectionReference _refProd =
      FirebaseFirestore.instance.collection("Produtos");
  final CollectionReference _refTot =
      FirebaseFirestore.instance.collection("Total");
  double _total = 0;
  double _preco = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _refProd.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> documentData = snapshot.data.data();
                  return ListView(
                    children: [
                      Image.network("${documentData['imagem']}"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.5,
                          horizontal: 10,
                        ),
                        child: Text(
                          documentData["nome"],
                          textScaleFactor: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.5,
                          horizontal: 15,
                        ),
                        child: Text(
                          documentData["descricao"],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3.5,
                          horizontal: 10,
                        ),
                        child: Text(
                          "R\$ ${documentData["preco"]}",
                          textScaleFactor: 3,
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      TextButton(
                          child: Text("Adicionar ao carrinho"),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            Carrin.tot += documentData['preco'];
                          }),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.orange,
                        iconSize: 40,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
