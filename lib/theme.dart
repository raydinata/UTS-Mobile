import 'package:flutter/material.dart';

const kOrange = Color(0xFFEE4D2D);
const kBg = Color(0xFFF5F5F5);
const kGreen = Color(0xFF26AA99);

/// Format angka ke Rupiah, contoh: 192000 -> Rp192.000
String rp(int v) {
  final s = v.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return '${v < 0 ? '-' : ''}Rp$b';
}
