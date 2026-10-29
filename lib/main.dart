import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/main_shell.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/orders_screen.dart';

/// Ganti angka ini untuk langsung menampilkan halaman tertentu (tanpa perlu ditekan):
/// 0 = Beranda, 1 = Keranjang, 2 = Checkout, 3 = Saya, 4 = Pesanan Saya
const int halamanAwal = 0;

Widget _pilihHalaman() {
  switch (halamanAwal) {
    case 1:
      return const CartScreen();
    case 2:
      return const CheckoutScreen();
    case 3:
      return const MainShell(tabAwal: 4);
    case 4:
      return const OrdersScreen();
    default:
      return const MainShell();
  }
}

void main() => runApp(const ShopeeApp());

class ShopeeApp extends StatelessWidget {
  const ShopeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopee Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: kOrange,
        scaffoldBackgroundColor: kBg,
        colorScheme: ColorScheme.fromSeed(seedColor: kOrange),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
          iconTheme: IconThemeData(color: kOrange),
        ),
      ),
      home: _pilihHalaman(),
    );
  }
}
