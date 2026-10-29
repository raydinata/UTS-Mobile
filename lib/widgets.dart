import 'package:flutter/material.dart';
import 'theme.dart';

/// Placeholder gambar produk (ganti dengan Image.asset / Image.network bila ada gambar).
class ProductThumb extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  const ProductThumb({super.key, this.size = 80, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Icon(icon, size: size * 0.5, color: color),
      );
}

/// Label "Star" / "Star+" oranye.
class StarBadge extends StatelessWidget {
  final bool plus;
  const StarBadge({super.key, this.plus = true});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(color: kOrange, borderRadius: BorderRadius.circular(3)),
        child: Text(plus ? 'Star+' : 'Star',
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
      );
}

/// Ikon keranjang + chat di header oranye.
class HeaderActions extends StatelessWidget {
  final VoidCallback onCart;
  const HeaderActions({super.key, required this.onCart});

  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          onTap: onCart,
          child: Stack(clipBehavior: Clip.none, children: [
            const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
            Positioned(
              right: -10,
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: const Text('99+',
                    style: TextStyle(color: kOrange, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
        ),
        const SizedBox(width: 18),
        const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 26),
      ]);
}
