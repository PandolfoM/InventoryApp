import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stockify/services/auth.dart';

class InventoryDrawer extends StatelessWidget {
  const InventoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            child: Text(
              'Current User Email',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout', style: Theme.of(context).textTheme.headline6),
          )
        ],
      ),
    );
  }
}
