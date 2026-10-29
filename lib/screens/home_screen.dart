import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openCart(BuildContext c) =>
      Navigator.push(c, MaterialPageRoute(builder: (_) => const CartScreen()));

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _header(context),
      Expanded(
        child: ListView(padding: EdgeInsets.zero, children: [
          _wallet(),
          _menuIcons(),
          _banner(),
          _liveVideo(),
          _products(),
        ]),
      ),
    ]);
  }

  Widget _header(BuildContext c) => Container(
        color: kOrange,
        padding: EdgeInsets.fromLTRB(14, MediaQuery.of(c).padding.top + 10, 14, 12),
        child: Row(children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: const Row(children: [
                Icon(Icons.search, color: kOrange),
                SizedBox(width: 8),
                Expanded(
                    child: Text('Sepatu Docmart Pria',
                        style: TextStyle(color: kOrange, fontSize: 16))),
                Icon(Icons.camera_alt_outlined, color: Colors.grey),
              ]),
            ),
          ),
          const SizedBox(width: 22),
          HeaderActions(onCart: () => _openCart(c)),
        ]),
      );

  Widget _wallet() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.qr_code_scanner, color: kOrange, size: 34),
          _walletItem('Rp609', 'Bayar QRIS', Icons.account_balance_wallet, kOrange),
          _walletItem('150', 'Cek Bonus Koin', Icons.monetization_on, Colors.amber),
          _walletItem('Kirim Uang', 'Gratis Admin', Icons.send, kOrange),
        ]),
      );

  Widget _walletItem(String t, String s, IconData i, Color c) => Row(children: [
        Icon(i, color: c, size: 20),
        const SizedBox(width: 4),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(s, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ]),
      ]);

  Widget _menuIcons() {
    const menus = [
      ['Pulsa &\nTagihan', Icons.phone_android, Colors.green],
      ['ShopeeFood', Icons.restaurant, kOrange],
      ['ShopeeVIP+', Icons.workspace_premium, Colors.amber],
      ['Hadiah\nShopee', Icons.card_giftcard, Colors.blue],
      ['Belanja\nInstant', Icons.two_wheeler, kGreen],
      ['Nonton\nDrama', Icons.ondemand_video, kOrange],
    ];
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: menus.length,
        itemBuilder: (_, i) => SizedBox(
          width: 82,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
                radius: 24,
                backgroundColor: (menus[i][2] as Color).withOpacity(0.12),
                child: Icon(menus[i][1] as IconData, color: menus[i][2] as Color)),
            const SizedBox(height: 6),
            Text(menus[i][0] as String,
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ]),
        ),
      ),
    );
  }

  Widget _banner() => Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFEE4D2D), Color(0xFFFF7337)]),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('CHECKOUT CHALLENGE',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
            Text('EKSTRA 45RB KOIN SHOPEE',
                style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('26 OKT - 1 NOV  •  MAIN SEKARANG',
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ]),
        ),
      );

  Widget _liveVideo() => Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(child: _mediaBox('Shopee Live', ['DENIM DISKON UP TO 50%', 'DISKON CUMA DI LIVE'], true)),
          const SizedBox(width: 10),
          Expanded(child: _mediaBox('Shopee Video', ['3RB', '10,6RB'], false)),
        ]),
      );

  Widget _mediaBox(String title, List<String> items, bool live) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$title >',
            style: const TextStyle(color: kOrange, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: items
              .map((t) => Expanded(
                    child: Container(
                      height: 130,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800, borderRadius: BorderRadius.circular(6)),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(5),
                      child: Text(t,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ))
              .toList(),
        ),
      ]);

  Widget _products() => Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.78),
          itemBuilder: (_, i) {
            final p = homeProducts[i];
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(6)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Stack(children: [
                    Positioned.fill(
                        child: Container(
                            color: p.color.withOpacity(0.12),
                            child: Icon(p.icon, size: 70, color: p.color))),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        color: const Color(0xFFFFEEE8),
                        child: Text(p.discount,
                            style: const TextStyle(color: kOrange, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(rp(p.price),
                        style: const TextStyle(color: kOrange, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ]),
            );
          },
        ),
      );
}
