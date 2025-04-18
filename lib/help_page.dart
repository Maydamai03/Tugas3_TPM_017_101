// lib/pages/help_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HelpPage extends StatelessWidget {
  // Fungsi untuk logout dan menghapus session
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📘 Cara Penggunaan Aplikasi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '• Gunakan menu di bawah untuk navigasi antara Beranda, Daftar Anggota, dan Bantuan.\n\n'
                    '• Pada halaman Beranda, Anda dapat mengakses berbagai fitur seperti Stopwatch, Tracking LBS, dan lainnya.\n\n'
                    '• Tekan tombol Logout jika Anda ingin keluar dari aplikasi dan menghapus sesi login.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 56, 43, 70),
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.amber,
              ),
              label: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 15.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
