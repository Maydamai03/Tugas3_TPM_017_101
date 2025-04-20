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

  final List<Map<String, dynamic>> helpItems = [
    {
      'title': 'Beranda',
      'steps': [
        'Pilih tab "Beranda" di bagian bawah aplikasi.',
        'Akses fitur seperti Stopwatch, Jenis Bilangan, LBS, dan lainnya.',
        'Klik menu yang ingin digunakan.'
      ]
    },
    {
      'title': 'Daftar Anggota',
      'steps': [
        'Pilih tab "Anggota".',
        'Lihat daftar anggota tim beserta NIM dan foto.'
      ]
    },
    {
      'title': 'Stopwatch',
      'steps': [
        'Buka fitur Stopwatch di halaman Beranda.',
        'Klik tombol Start untuk mulai menghitung waktu.',
        'Gunakan tombol lap untuk membagi waktu beserta lap nya',
        'Gunakan tombol Stop dan Reset untuk mengatur ulang.'
      ]
    },
    {
      'title': 'Jenis Bilangan',
      'steps': [
        'Pilih fitur Jenis Bilangan dari Beranda.',
        'Masukkan angka yang ingin dianalisis.',
        'Sistem akan menampilkan apakah angka tersebut prima, desimal, positif/negatif, atau bilangan cacah.'
      ]
    },
    {
      'title': 'Tracking Lokasi (LBS)',
      'steps': [
        'Pilih fitur LBS dari Beranda.',
        'Izinkan aplikasi mengakses lokasi.',
        'Lihat posisi Anda di peta secara real-time.'
      ]
    },
    {
      'title': 'Konversi Waktu',
      'steps': [
        'Pilih fitur Konversi Waktu dari Beranda.',
        'Masukkan jumlah tahun yang ingin dikonversi.',
        'Hasil akan ditampilkan dalam jam, menit, dan detik.',
      ]
    },
    {
      'title': 'Situs Rekomendasi',
      'steps': [
        'Buka fitur Situs Rekomendasi dari Beranda.',
        'Lihat daftar situs-situs yang direkomendasikan.',
        'Tambahkan situs ke favorit untuk akses cepat.'
      ]
    },
  ];

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
          Text(
            '📘 Informasi & Panduan Penggunaan',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: helpItems.length,
                    itemBuilder: (context, index) {
                      final item = helpItems[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            item['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          children: List.generate(
                            item['steps'].length,
                            (i) => ListTile(
                              leading: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                item['steps'][i],
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
