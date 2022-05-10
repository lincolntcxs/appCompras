import 'package:flutter/material.dart';
import 'package:reo4/home.dart';

class Entrega extends StatefulWidget {
  @override
  _EntregaState createState() => _EntregaState();
}

class _EntregaState extends State<Entrega> {
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
                  title: Text('Preencha os campos'),
                  backgroundColor: Colors.orangeAccent,
                  centerTitle: true,
                ),
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.orange,
                      labelText: 'Nome',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data de nascimento',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Endereço',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextButton(
                    child: Text("Finalizar"),
                    style: TextButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // retorna um objeto do tipo Dialog
                          return AlertDialog(
                            title: new Text("Compra finalizada com sucesso !"),
                            content: new Text(
                                "Parabéns sua compra foi realizada com sucesso, seu produto chegará conforme a data de entrega prevista !"),
                            actions: <Widget>[
                              // define os botões na base do dialogo
                              new TextButton(
                                child: new Text("Fechar"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaHome()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
