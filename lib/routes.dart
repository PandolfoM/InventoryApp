import 'package:stockify/home/home.dart';
import 'package:stockify/inventory/inventory.dart';
import 'package:stockify/login/login.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/inventory': (context) => const InventoryScreen(),
  '/login': (context) => const LoginScreen(),
};
