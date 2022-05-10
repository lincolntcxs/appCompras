import 'package:reo4/home.dart';
import 'package:reo4/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Column(
                    children: <Widget>[
                      Image.asset('assets/images/logo.png', fit: BoxFit.fill),
                    ],
                  ),
                );
              }
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User _user = streamSnapshot.data;
                if (_user == null) {
                  return TelaLogin();
                } else {
                  return TelaHome();
                }
              }
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    Image.asset('assets/images/logo.png', fit: BoxFit.fill),
                  ],
                ),
              );
            },
          );
        }
        // Connecting to Firebase - Loading
        return Scaffold(
          body: Center(
            child: Text(
              "Conectando ao FireBase",
            ),
          ),
        );
      },
    );
  }
}
