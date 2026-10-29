import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Kerangka utama dengan bottom navigation (Beranda & Saya terhubung).
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.tabAwal = 0});
  final int tabAwal;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index = widget.tabAwal;

  Widget _placeholder(String t) => Center(child: Text(t, style: const TextStyle(color: Colors.grey)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: [
        const HomeScreen(),
        _placeholder('Deals'),
        _placeholder('Live & Video'),
        _placeholder('Notifikasi'),
        const ProfileScreen(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedItemColor: kOrange,
        unselectedItemColor: Colors.black54,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer_outlined), label: 'Deals'),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv_outlined), label: 'Live & Video'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Saya'),
        ],
      ),
    );
  }
}
