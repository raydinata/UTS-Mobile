import 'package:flutter/material.dart';

class Product {
  final String store;
  final String name;
  final String variant;
  final int price;
  final int? oldPrice;
  final bool plus;
  final Color color;
  final IconData icon;
  int qty;

  Product({
    required this.store,
    required this.name,
    required this.variant,
    required this.price,
    this.oldPrice,
    this.plus = true,
    this.qty = 1,
    required this.color,
    required this.icon,
  });
}

List<Product> cartItems() => [
      Product(
        store: 'Mr. Jonsrawk Official',
        name: 'Mr.Jonsrawk Official - Sepatu Formal Kondangan Pria',
        variant: 'JAHITAN SOL KUNING, 41',
        price: 181450,
        oldPrice: 350000,
        color: Colors.black87,
        icon: Icons.snowshoeing,
      ),
      Product(
        store: 'Wingman Store',
        name: 'BAN TOMIMOTO TM300 TUBELESS RING 14',
        variant: 'TM300 100/80-14',
        price: 301900,
        plus: false,
        color: Colors.deepOrange,
        icon: Icons.tire_repair,
      ),
      Product(
        store: 'Good Otoparts',
        name: 'Oribaru - Saklar/Holder Kanan R/H Vario',
        variant: 'Hitam',
        price: 95000,
        color: Colors.blueGrey,
        icon: Icons.settings,
      ),
    ];

class Order {
  final String store;
  final bool plus;
  final String name;
  final String variant;
  final int price;
  final int totalItems;
  final int total;
  final bool canRate;
  final Color color;
  final IconData icon;

  const Order({
    required this.store,
    this.plus = true,
    required this.name,
    required this.variant,
    required this.price,
    this.totalItems = 1,
    required this.total,
    this.canRate = false,
    required this.color,
    required this.icon,
  });
}

const doneOrders = [
  Order(
    store: 'TQ6 Official',
    name: 'Swing arm billet full cnc TQ6 V3 Vario125/150',
    variant: 'Vario125/150, SWING ARM-TQ6',
    price: 766000,
    total: 543598,
    canRate: true,
    color: Colors.blueGrey,
    icon: Icons.build,
  ),
  Order(
    store: 'davecolection95',
    name: 'Emblem Hugger Airblade Stainless LiquiMoly',
    variant: 'Hrc',
    price: 14990,
    total: 15187,
    color: Colors.grey,
    icon: Icons.emoji_events,
  ),
  Order(
    store: 'bautoriginalthailand1',
    name: '(1 SET ISI 2 BUAH) emblem body look stainless',
    variant: 'Click',
    price: 85000,
    totalItems: 2,
    total: 146778,
    color: Colors.brown,
    icon: Icons.label,
  ),
];

class HomeProduct {
  final String name;
  final int price;
  final String discount;
  final Color color;
  final IconData icon;
  const HomeProduct(this.name, this.price, this.discount, this.color, this.icon);
}

const homeProducts = [
  HomeProduct('Raingel Fort Maroon Sepatu Sneakers Pria', 189000, '-50%', Colors.brown, Icons.snowshoeing),
  HomeProduct('Mr.Jonsrawk Sepatu Formal Kondangan', 181450, '-48%', Colors.black87, Icons.snowshoeing),
  HomeProduct('Kaos Polos Cotton Combed 30s', 49000, '-30%', Colors.green, Icons.checkroom),
  HomeProduct('Celana Chino Pria Slimfit', 125000, '-35%', Colors.teal, Icons.checkroom),
];
