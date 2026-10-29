import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';

class OrdersScreen extends StatelessWidget {
  final int initialTab;
  const OrdersScreen({super.key, this.initialTab = 3});

  static const tabs = ['Belum Bayar', 'Dikemas', 'Dikirim', 'Selesai', 'Pengembalian', 'Dibatalkan'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialTab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan Saya', style: TextStyle(fontSize: 20)),
          actions: const [
            Icon(Icons.search, color: kOrange, size: 28),
            SizedBox(width: 16),
            Icon(Icons.chat_bubble_outline, color: kOrange),
            SizedBox(width: 14),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: kOrange,
            unselectedLabelColor: Colors.black87,
            indicatorColor: kOrange,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: [for (final t in tabs) Tab(text: t)],
          ),
        ),
        body: TabBarView(children: [
          for (var i = 0; i < tabs.length; i++)
            i == 3
                ? ListView(
                    padding: const EdgeInsets.all(10),
                    children: [for (final o in doneOrders) _OrderCard(o)],
                  )
                : Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.receipt_long_outlined, size: 70, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      const Text('Belum ada pesanan', style: TextStyle(color: Colors.grey)),
                    ]),
                  ),
        ]),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order o;
  const _OrderCard(this.o);

  Widget _btn(String t, {bool primary = false}) => OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: primary ? kOrange : Colors.black87,
          side: BorderSide(color: primary ? kOrange : Colors.grey.shade400),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(t, style: const TextStyle(fontSize: 16)),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          StarBadge(plus: o.plus),
          const SizedBox(width: 6),
          Expanded(
              child: Text(o.store,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis)),
          const Text('Selesai', style: TextStyle(color: kOrange, fontSize: 15)),
        ]),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProductThumb(size: 85, color: o.color, icon: o.icon),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 85,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(o.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                Row(children: [
                  Expanded(
                      child: Text(o.variant,
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis)),
                  const Text('x1', style: TextStyle(color: Colors.grey)),
                ]),
                const Spacer(),
                Align(alignment: Alignment.centerRight, child: Text(rp(o.price), style: const TextStyle(fontSize: 16))),
              ]),
            ),
          ),
        ]),
        if (o.totalItems > 1)
          const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('Lihat Semua  ⌄', style: TextStyle(color: Colors.black54, fontSize: 16)),
          )),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text.rich(TextSpan(children: [
            TextSpan(text: 'Total ${o.totalItems} produk: '),
            TextSpan(text: rp(o.total), style: const TextStyle(fontWeight: FontWeight.w600)),
          ]), style: const TextStyle(fontSize: 16)),
        ),
        if (o.canRate) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(6)),
            child: const Row(children: [
              Icon(Icons.monetization_on, color: Colors.amber),
              SizedBox(width: 10),
              Expanded(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Nilai pesanan sebelum 6 Jan untuk dapatkan\n'),
                  TextSpan(text: '140 Koin', style: TextStyle(color: kOrange, fontSize: 16)),
                ])),
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ]),
          ),
        ],
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          if (o.canRate) ...[_btn('Beli Lagi'), const SizedBox(width: 10), _btn('Nilai', primary: true)]
          else ...[_btn('Lihat Penilaian'), const SizedBox(width: 10), _btn('Beli Lagi', primary: true)],
        ]),
      ]),
    );
  }
}
