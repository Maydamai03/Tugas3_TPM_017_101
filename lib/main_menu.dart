// lib/pages/main_menu.dart
import 'package:flutter/material.dart';
import 'package:tugas3_tpm/konversi_waktu.dart';
import 'package:tugas3_tpm/situs_rekomendasi.dart';
import 'package:tugas3_tpm/stopwatch.dart';
import 'package:tugas3_tpm/tracking_lbs.dart';
import 'jenis_bilangan.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Aksi untuk menu Stopwatch
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StopwatchPage()),
              );
            },
            child: Text('Stopwatch'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk menu Jenis Bilangan
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JenisBilanganPage()),
              );
            },
            child: Text('Jenis Bilangan'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk menu Tracking LBS
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackingLbsPage()),
              );
            },
            child: Text('Tracking LBS'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk menu Konversi Waktu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KonversiWaktuPage()),
              );
            },
            child: Text('Konversi Waktu'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk menu Daftar Situs Rekomendasi
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SitusRekomendasiPage()),
              );
            },
            child: Text('Situs Rekomendasi'),
          ),
        ],
      ),
    );
  }
}
