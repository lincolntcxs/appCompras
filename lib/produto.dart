import 'package:flutter/material.dart';

class Produto extends StatelessWidget {
  final String imagem;
  final String nome;
  final String preco;
  final String descricao;
  final String productId;
  final Function onPressed;
  Produto(
      {this.onPressed,
      this.imagem,
      this.nome,
      this.preco,
      this.descricao,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 100.0,
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 4.0,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nome,
                    ),
                    Text(
                      imagem,
                    ),
                    Text(
                      descricao,
                    ),
                    Text(
                      preco,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
