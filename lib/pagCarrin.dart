import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reo4/entrega.dart';

class Carrin extends StatefulWidget {
  static double tot = 0;

  @override
  _CarrinState createState() => _CarrinState();
}

class _CarrinState extends State<Carrin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              child: AppBar(
                title:
                    Text("Valor total: R\$: ${Carrin.tot.toStringAsFixed(2)}"),
                centerTitle: true,
                backgroundColor: Colors.orangeAccent,
              ),
            ),
            TextButton(
              child: Text('Limpar carrinho'),
              style: TextButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                setState(() {
                  Carrin.tot = 0.0;
                });
              },
            ),
            TextButton(
              child: Text('Finalizar compra'),
              style: TextButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                setState(() {
                  Carrin.tot = 0.0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entrega()),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
