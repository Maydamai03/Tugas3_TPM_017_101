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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuButton(
                context,
                label: "Stopwatch",
                icon: Icons.timer,
                page: StopwatchPage(),
              ),
              _buildMenuButton(
                context,
                label: "Jenis Bilangan",
                icon: Icons.calculate,
                page: JenisBilanganPage(),
              ),
              _buildMenuButton(
                context,
                label: "Tracking LBS",
                icon: Icons.location_on,
                page: TrackingLbsPage(),
              ),
              _buildMenuButton(
                context,
                label: "Konversi Waktu",
                icon: Icons.access_time,
                page: KonversiWaktuPage(),
              ),
              _buildMenuButton(
                context,
                label: "Situs Rekomendasi",
                icon: Icons.link,
                page: SitusRekomendasiPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required String label, required IconData icon, required Widget page}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          icon: Icon(icon),
          label: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromARGB(255, 81, 62, 100),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
