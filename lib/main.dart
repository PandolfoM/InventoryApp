import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stockify/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Stockify());
}

class Stockify extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Stockify({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: MaterialApp(
              routes: appRoutes,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
