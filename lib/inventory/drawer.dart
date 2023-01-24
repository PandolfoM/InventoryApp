import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stockify/services/auth.dart';

class InventoryDrawer extends StatelessWidget {
  const InventoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  AuthService().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }),
          ),
        ),
      ),
    );
  }
}
