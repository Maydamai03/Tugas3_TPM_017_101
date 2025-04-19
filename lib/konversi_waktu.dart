// lib/pages/konversi_waktu_page.dart
import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  @override
  _KonversiWaktuPageState createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  TextEditingController _controller = TextEditingController();
  String _result = '';
  String selectedTarget = 'Semua';

  void _convertTime() {
    setState(() {
      _result = '';

      String inputText = _controller.text;
      if (inputText.isEmpty) {
        _result = 'Masukkan jumlah tahun!';
        return;
      }

      double years = double.tryParse(inputText) ?? 0;
      double months = years * 12;
      double days = years * 365;
      double hours = days * 24;
      double minutes = hours * 60;
      double seconds = minutes * 60;

      switch (selectedTarget) {
        case 'Bulan':
          _result = '$years tahun = $months bulan';
          break;
        case 'Hari':
          _result = '$years tahun = $days hari';
          break;
        case 'Jam':
          _result = '$years tahun = $hours jam';
          break;
        case 'Menit':
          _result = '$years tahun = $minutes menit';
          break;
        case 'Detik':
          _result = '$years tahun = $seconds detik';
          break;
        default:
          _result =
              '$years tahun = $months bulan, $days hari, $hours jam, $minutes menit, $seconds detik';
      }
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
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan jumlah tahun',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedTarget,
              items: <String>[
                'Semua',
                'Bulan',
                'Hari',
                'Jam',
                'Menit',
                'Detik'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Konversi ke $value'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTarget = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTime,
              child: Text('Konversi'),
            ),
            SizedBox(height: 20),
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
