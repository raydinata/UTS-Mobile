import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showNotice = true;

  void _orders(int tab) => Navigator.push(
      context, MaterialPageRoute(builder: (_) => OrdersScreen(initialTab: tab)));

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero, children: [
      _header(),
      if (showNotice) _notice(),
      _section(
        'Pesanan Saya',
        'Lihat Riwayat Pesanan',
        onTap: () => _orders(3),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _icon('Belum Bayar', Icons.account_balance_wallet_outlined, onTap: () => _orders(0)),
            _icon('Dikemas', Icons.inventory_2_outlined, onTap: () => _orders(1)),
            _icon('Dikirim', Icons.local_shipping_outlined, onTap: () => _orders(2)),
            _icon('Beri Penilaian', Icons.star_border, badge: '6', onTap: () => _orders(3)),
          ]),
        ),
      ),
      Container(
        color: Colors.white,
        child: Column(children: [
          const Divider(height: 1),
          _tile(Icons.phone_android, 'Pulsa, Tagihan & Tiket', null, Colors.green),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _tile(Icons.restaurant, 'ShopeeFood', 'Gratis Ongkir', kOrange),
        ]),
      ),
      _section(
        'Dompet Saya',
        null,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _icon('ShopeePay', Icons.account_balance_wallet, sub: 'Bayar QRIS'),
            _icon('Koin Shopee', Icons.monetization_on_outlined, sub: 'Klaim Bonus', dot: true),
            _icon('Voucher Saya', Icons.confirmation_number_outlined, sub: '50+ Voucher', dot: true),
            _icon('Bonus Rp1.250', Icons.savings_outlined, sub: 'Klaim Saldo'),
          ]),
        ),
      ),
      _section(
        'Keuangan',
        'Lihat Semua',
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _icon('SPayLater', Icons.schedule, sub: 'Rp15.992.116', color: Colors.blue)),
            Expanded(child: _icon('SPinjam', Icons.payments_outlined, sub: 'Limit Kedaluwarsa')),
            Expanded(child: _icon('SeaBank', Icons.account_balance, sub: 'Gratis Transfer\nAntar Bank')),
            Expanded(child: _icon('Asuransi', Icons.verified_user, sub: 'Dapatkan\npertanggungan ...')),
          ]),
        ),
      ),
      _section(
        'Aktivitas Saya',
        'Lihat Semua',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(children: [
            Expanded(child: _activity(Icons.card_giftcard, 'Shopee Affiliate\nProgram')),
            const SizedBox(width: 12),
            Expanded(child: _activity(Icons.favorite_border, 'Favorit Saya')),
          ]),
        ),
      ),
    ]);
  }

  Widget _header() => Container(
        padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 10, 16, 14),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFEE4D2D), Color(0xFFFF6A3D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: const Row(children: [
                Icon(Icons.storefront_outlined, size: 20),
                SizedBox(width: 6),
                Text('Mulai Jual', style: TextStyle(fontSize: 15)),
                Icon(Icons.chevron_right, size: 18),
              ]),
            ),
            const Spacer(),
            const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
            const SizedBox(width: 22),
            HeaderActions(
              onCart: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const CartScreen())),
            ),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            const CircleAvatar(
                radius: 33,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.grey)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Text('raydinata08',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: const Color(0xFFE8C77B), borderRadius: BorderRadius.circular(10)),
                    child: const Text('Gold >', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ]),
                const SizedBox(height: 4),
                const Text('0 Pengikut     5 Mengikuti', style: TextStyle(color: Colors.white70)),
              ]),
            ),
          ]),
        ]),
      );

  Widget _notice() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          const Icon(Icons.edit_note, color: kOrange, size: 30),
          const SizedBox(width: 10),
          const Expanded(
            child: Text.rich(TextSpan(children: [
              TextSpan(text: 'Silakan atur Nama, Jenis Kelamin, Tanggal Lahir-mu. '),
              TextSpan(text: 'Atur Sekarang', style: TextStyle(color: Colors.blue)),
            ])),
          ),
          InkWell(
              onTap: () => setState(() => showNotice = false),
              child: const Icon(Icons.close, color: Colors.grey)),
        ]),
      );

  Widget _section(String title, String? action, {required Widget child, VoidCallback? onTap}) =>
      Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const Spacer(),
                if (action != null) ...[
                  Text(action, style: const TextStyle(color: Colors.black54)),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                ],
              ]),
            ),
          ),
          child,
        ]),
      );

  Widget _icon(String label, IconData icon,
      {String? sub, String? badge, bool dot = false, Color? color, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(children: [
        Stack(clipBehavior: Clip.none, children: [
          Icon(icon, size: 34, color: color ?? Colors.black87),
          if (badge != null)
            Positioned(
              right: -8,
              top: -8,
              child: CircleAvatar(
                  radius: 9,
                  backgroundColor: kOrange,
                  child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 11))),
            ),
          if (dot)
            const Positioned(
                right: -4, top: -4, child: CircleAvatar(radius: 4, backgroundColor: kOrange)),
        ]),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13), textAlign: TextAlign.center),
        if (sub != null)
          Text(sub,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kOrange, fontSize: 12)),
      ]),
    );
  }

  Widget _tile(IconData i, String t, String? trailing, Color c) => ListTile(
        leading: Icon(i, color: c, size: 30),
        title: Text(t, style: const TextStyle(fontSize: 18)),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          if (trailing != null) Text(trailing, style: const TextStyle(color: kOrange)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ]),
      );

  Widget _activity(IconData i, String t) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
        child: Row(children: [
          Icon(i, color: kOrange, size: 30),
          const SizedBox(width: 10),
          Expanded(child: Text(t, style: const TextStyle(fontSize: 16))),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ]),
      );
}
