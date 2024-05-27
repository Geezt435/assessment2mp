import 'package:flutter/material.dart';
import 'halaman_satu.dart';
import 'halaman_dua.dart';
import 'halaman_tiga.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Mobile',
      initialRoute: '/',
      routes: {
        '/': (context) => HalamanSatu(),
        '/halaman-dua': (context) => HalamanDua(),
        '/halaman-tiga': (context) => HalamanTiga(),
      },
    );
  }
}