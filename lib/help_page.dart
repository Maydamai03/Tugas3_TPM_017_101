// lib/pages/help_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HelpPage extends StatelessWidget {
  // Fungsi untuk logout dan menghapus session
  void _logout(BuildContext context) async {
    // Mengambil instance SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Menghapus session dengan menghapus key 'isLoggedIn'
    await prefs.clear();

    // Mengarahkan kembali ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul dan deskripsi cara penggunaan aplikasi
          Text(
            'Cara Penggunaan Aplikasi:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('1. Pilih menu sesuai dengan kebutuhan Anda.'),
          Text('2. Untuk menghitung, pilih menu yang relevan.'),
          Text('3. Logout untuk keluar dari aplikasi.'),
          SizedBox(height: 20),

          // Tombol logout
          ElevatedButton(
            onPressed: () => _logout(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
