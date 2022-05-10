import 'package:reo4/produto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reo4/pagProd.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Produtos");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Erro: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagProd(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        height: 300.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 300,
                              child: ClipRect(
                                child: Image.network(
                                  "${(document.data()['imagem'])}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document.data()['nome'] ?? "Produto",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "R\$${document.data()['preco']}" ??
                                          "Produto",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Text(
            "   Conheça nossos produtos !",
            textAlign: TextAlign.center,
            textScaleFactor: 2,
            style: TextStyle(color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
