import 'package:flutter/material.dart';
import 'package:stockify/inventory/inventory.dart';
import 'package:stockify/login/login.dart';
import 'package:stockify/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error!'),
          );
        } else if (snapshot.hasData) {
          return const InventoryScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
