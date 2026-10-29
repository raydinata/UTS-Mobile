import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final items = cartItems();
  final Set<int> selected = {};

  int get total => selected.fold(0, (a, i) => a + items[i].price * items[i].qty);
  bool get allSelected => selected.length == items.length;

  void _toggleAll(bool? v) => setState(() {
        selected.clear();
        if (v == true) selected.addAll(List.generate(items.length, (i) => i));
      });

  void _checkout() {
    final chosen = selected.map((i) => items[i]).toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(selectedItems: chosen)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(text: 'Keranjang Saya ', style: TextStyle(fontSize: 20)),
          TextSpan(text: '(128)', style: const TextStyle(fontSize: 14, color: Colors.black54)),
        ])),
        actions: const [
          Center(child: Text('Ubah', style: TextStyle(color: Colors.black87, fontSize: 16))),
          SizedBox(width: 14),
          Icon(Icons.chat_bubble_outline, color: kOrange),
          SizedBox(width: 14),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView(padding: const EdgeInsets.all(10), children: [
            for (var i = 0; i < items.length; i++) ...[
              _itemCard(i),
              if (i == 0) _cleanup(),
            ],
          ]),
        ),
        _bottomBar(),
      ]),
    );
  }

  Widget _cleanup() => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          const Icon(Icons.cleaning_services, color: kOrange),
          const SizedBox(width: 8),
          const Expanded(child: Text('Hapus produk yang sudah tidak kamu perlukan.')),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                foregroundColor: kOrange, side: const BorderSide(color: kOrange)),
            child: const Text('Hapus'),
          ),
        ]),
      );

  Widget _itemCard(int i) {
    final p = items[i];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
          child: Row(children: [
            Checkbox(
              value: selected.contains(i),
              activeColor: kOrange,
              onChanged: (v) => setState(() => v! ? selected.add(i) : selected.remove(i)),
            ),
            StarBadge(plus: p.plus),
            const SizedBox(width: 6),
            Text(p.store, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Icon(Icons.chevron_right, size: 18, color: Colors.black54),
            const Spacer(),
            const Text('Ubah', style: TextStyle(color: Colors.black54, fontSize: 15)),
          ]),
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Checkbox(
            value: selected.contains(i),
            activeColor: kOrange,
            onChanged: (v) => setState(() => v! ? selected.add(i) : selected.remove(i)),
          ),
          ProductThumb(size: 85, color: p.color, icon: p.icon),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12, top: 4),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      color: kBg,
                      child: Text(p.variant,
                          style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Spacer(),
                  _qty(p),
                ]),
                const SizedBox(height: 6),
                Text(rp(p.price),
                    style: const TextStyle(
                        color: kOrange, fontSize: 18, fontWeight: FontWeight.w500)),
              ]),
            ),
          ),
        ]),
        const Divider(height: 18),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Row(children: [
            const Icon(Icons.confirmation_number_outlined, color: kOrange),
            const SizedBox(width: 10),
            Text(i == 0 ? 'Tersedia Voucher Diskon s/d Rp1RB' : 'Tambahkan kode Voucher Toko',
                style: TextStyle(color: i == 0 ? Colors.black87 : Colors.grey)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ]),
        ),
      ]),
    );
  }

  Widget _qty(Product p) => Row(children: [
        InkWell(
            onTap: () => setState(() {
                  if (p.qty > 1) p.qty--;
                }),
            child: const Icon(Icons.remove, size: 18, color: Colors.black54)),
        Container(
          width: 38,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.center,
          color: kBg,
          child: Text('${p.qty}', style: const TextStyle(fontSize: 16)),
        ),
        InkWell(
            onTap: () => setState(() => p.qty++),
            child: const Icon(Icons.add, size: 18, color: Colors.black54)),
      ]);

  Widget _bottomBar() => Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const ListTile(
              dense: true,
              leading: Icon(Icons.confirmation_number_outlined, color: kOrange),
              title: Text('Voucher', style: TextStyle(fontSize: 16)),
              trailing: Text('Gunakan/masukkan kode >', style: TextStyle(color: Colors.grey)),
            ),
            const Divider(height: 1),
            ListTile(
              dense: true,
              leading: const Icon(Icons.monetization_on_outlined, color: Colors.amber),
              title: Text(selected.isEmpty ? 'Tidak ada produk yang dipilih' : 'Pakai Koin Shopee',
                  style: const TextStyle(fontSize: 16)),
              trailing: Switch(value: false, onChanged: (_) {}),
            ),
            const Divider(height: 1),
            Row(children: [
              Checkbox(value: allSelected, activeColor: kOrange, onChanged: _toggleAll),
              const Text('Semua', style: TextStyle(fontSize: 16)),
              const Spacer(),
              Text(rp(total),
                  style: const TextStyle(
                      color: kOrange, fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(width: 10),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: selected.isEmpty ? null : _checkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kOrange,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: kOrange.withOpacity(0.5),
                    disabledForegroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                  ),
                  child: Text('Checkout (${selected.length})',
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 12),
            ]),
          ]),
        ),
      );
}
