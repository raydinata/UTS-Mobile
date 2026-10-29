import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product>? selectedItems;
  const CheckoutScreen({super.key, this.selectedItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final List<Product> items = widget.selectedItems ?? [cartItems().first];
  bool protect = true;
  int shipping = 0;

  int get subtotal => items.fold(0, (a, p) => a + p.price * p.qty);
  int get protectFee => protect ? 1700 * items.length : 0;
  int get saved => items.fold(0, (a, p) => a + ((p.oldPrice ?? p.price) - p.price) * p.qty);
  int get total => subtotal + protectFee;

  void _order() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const OrdersScreen()),
      (route) => route.isFirst,
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Pesanan berhasil dibuat')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout', style: TextStyle(fontSize: 20)), centerTitle: true),
      body: Column(children: [
        Expanded(
          child: ListView(padding: const EdgeInsets.all(10), children: [
            _address(),
            for (final p in items) _storeCard(p),
          ]),
        ),
        _bottomBar(),
      ]),
    );
  }

  Widget _address() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(bottom: 10),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.location_on, color: kOrange),
          SizedBox(width: 8),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: 'wisworo ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                TextSpan(text: '(+62) 815-4890-0413', style: TextStyle(color: Colors.grey)),
              ])),
              SizedBox(height: 4),
              Text('Jalan Siwalan, RT.6/RW.1, Dk. Tambakyuda, Ds. Bojongnangka, Pemalang '
                  '(samping toko yayah)\nPEMALANG, KAB. PEMALANG, JAWA TENGAH, ID 52318'),
            ]),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ]),
      );

  Widget _storeCard(Product p) {
    final dates = ['31 Okt', '31 Okt - 1 Nov'];
    final names = ['Reguler', 'Hemat Kargo'];
    final oldFee = [8000, 5000];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          StarBadge(plus: p.plus),
          const SizedBox(width: 8),
          Text(p.store, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ]),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProductThumb(size: 80, color: p.color, icon: p.icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(p.variant, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 14),
              Row(children: [
                Text(rp(p.price),
                    style: const TextStyle(color: kOrange, fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                if (p.oldPrice != null)
                  Text(rp(p.oldPrice!),
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 13, decoration: TextDecoration.lineThrough)),
                const Spacer(),
                Text('x${p.qty}'),
              ]),
            ]),
          ),
        ]),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(6)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              InkWell(
                onTap: () => setState(() => protect = !protect),
                child: Icon(protect ? Icons.check_box : Icons.check_box_outline_blank,
                    color: kOrange, size: 28),
              ),
              const SizedBox(width: 8),
              const Text('Proteksi Kerusakan +',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const Spacer(),
              const Text('Rp1.700 x1'),
            ]),
            const SizedBox(height: 6),
            const Text('Dapatkan kompensasi 100% jika barang rusak total atau dicuri dalam 6 bulan.',
                style: TextStyle(color: Colors.black54, fontSize: 13)),
          ]),
        ),
        const SizedBox(height: 14),
        _row('Voucher Toko', '-Rp1RB', valueColor: kOrange),
        const SizedBox(height: 12),
        _row('Pesan untuk Penjual', 'Tinggalkan pesan', valueColor: Colors.grey),
        const Divider(height: 28),
        _row('Opsi Pengiriman', 'Lihat Semua', valueColor: Colors.black54),
        const SizedBox(height: 10),
        for (var i = 0; i < 2; i++)
          GestureDetector(
            onTap: () => setState(() => shipping = i),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: shipping == i ? const Color(0xFFF0FAF8) : Colors.white,
                border: Border.all(color: shipping == i ? kGreen : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(dates[i],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: shipping == i ? kGreen : Colors.black87)),
                    Text(names[i], style: const TextStyle(color: Colors.black54)),
                  ]),
                ),
                Text(rp(oldFee[i]),
                    style: const TextStyle(
                        color: Colors.grey, decoration: TextDecoration.lineThrough)),
                const SizedBox(width: 6),
                const Text('Rp0', style: TextStyle(fontSize: 16)),
              ]),
            ),
          ),
        Row(children: [
          const Expanded(
              child: Text('Voucher s/d Rp10.000 jika pesanan terlambat.',
                  style: TextStyle(color: Colors.black54))),
        ]),
        const Divider(height: 28),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total ${p.qty} Produk', style: const TextStyle(fontSize: 16)),
          Text(rp(p.price * p.qty + (protect ? 1700 : 0)),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ]),
      ]),
    );
  }

  Widget _row(String l, String v, {Color? valueColor}) => Row(children: [
        Text(l, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(v, style: TextStyle(color: valueColor, fontSize: 15)),
        const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      ]);

  Widget _bottomBar() => Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text.rich(TextSpan(children: [
                  const TextSpan(text: 'Total '),
                  TextSpan(
                      text: rp(total),
                      style: const TextStyle(
                          color: kOrange, fontSize: 20, fontWeight: FontWeight.w500)),
                ])),
                Text.rich(TextSpan(children: [
                  const TextSpan(text: 'Hemat '),
                  TextSpan(text: rp(saved), style: const TextStyle(color: kOrange)),
                ])),
              ]),
              const SizedBox(width: 12),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _order,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                  ),
                  child: const Text('Buat Pesanan', style: TextStyle(fontSize: 18)),
                ),
              ),
            ]),
          ),
        ),
      );
}
