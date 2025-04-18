// lib/pages/konversi_waktu_page.dart
import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  @override
  _KonversiWaktuPageState createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  TextEditingController _controller = TextEditingController();
  String _result = '';

  // Fungsi untuk konversi tahun ke jam, menit, detik
  void _convertTime() {
    setState(() {
      _result = ''; // Reset result jika ada input baru

      String inputText = _controller.text;
      if (inputText.isEmpty) {
        _result = 'Masukkan jumlah tahun!';
        return;
      }

      double years = double.tryParse(inputText) ?? 0;
      
      // Mengonversi tahun ke jam, menit, detik
      double hours = years * 365 * 24; // 1 tahun = 365 hari * 24 jam
      double minutes = hours * 60; // 1 jam = 60 menit
      double seconds = minutes * 60; // 1 menit = 60 detik

      _result = '$years tahun = $hours jam, $minutes menit, $seconds detik';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Waktu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input field untuk tahun
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan jumlah tahun',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Tombol konversi
            ElevatedButton(
              onPressed: _convertTime,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil konversi
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
