import 'package:flutter/material.dart';

class JenisBilanganPage extends StatefulWidget {
  @override
  _JenisBilanganPageState createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  TextEditingController _controller = TextEditingController();

  // Variabel hasil terpisah
  String _result = '';
  String _primeResult = '';
  String _decimalResult = '';
  String _numberTypeResult = '';
  String _cacahResult = '';

  // Cek bilangan prima
  bool _isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  // Jenis bilangan bulat
  String _getNumberType(int number) {
    if (number > 0) {
      return 'Bulat Positif';
    } else if (number < 0) {
      return 'Bulat Negatif';
    } else {
      return 'Cacah';
    }
  }

  // Cek apakah desimal
  bool _isDecimal(String value) {
    return value.contains('.');
  }

  // Proses pengecekan
  void _checkNumber() {
    setState(() {
      _result = '';
      _primeResult = '';
      _decimalResult = '';
      _numberTypeResult = '';
      _cacahResult = '';

      String inputText = _controller.text;

      if (inputText.isEmpty) {
        _result = 'Masukkan angka terlebih dahulu!';
        return;
      }

      double? inputValue = double.tryParse(inputText);
      if (inputValue == null) {
        _result = 'Input tidak valid!';
        return;
      }

      // Proses masing-masing hasil
      _primeResult = inputValue % 1 == 0 && _isPrime(inputValue.toInt())
          ? '$inputValue adalah bilangan Prima'
          : '$inputValue bukan bilangan Prima';

      _decimalResult = _isDecimal(inputText)
          ? '$inputText adalah bilangan Desimal'
          : '$inputText bukan bilangan Desimal';

      _numberTypeResult = inputValue % 1 == 0
          ? 'Jenis Bilangan: ${_getNumberType(inputValue.toInt())}'
          : 'Jenis Bilangan: Desimal';

      _cacahResult = inputValue % 1 == 0 && inputValue >= 0
          ? '$inputValue adalah bilangan Cacah'
          : '$inputValue bukan bilangan Cacah';
    });
  }

  // Widget hasil tampilan baris per baris
  Widget _buildResultRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 24, color: Colors.blue), // Ikon seragam
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis Bilangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Input angka
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Tombol cek
            ElevatedButton(
              onPressed: _checkNumber,
              child: Text('Cek Jenis Bilangan'),
            ),
            SizedBox(height: 20),

            // Menampilkan hasil
            _result.isNotEmpty
                ? Text(
                    _result,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_primeResult.isNotEmpty)
                        _buildResultRow('Bilangan Prima: $_primeResult'),
                      if (_decimalResult.isNotEmpty)
                        _buildResultRow('Bilangan Desimal: $_decimalResult'),
                      if (_numberTypeResult.isNotEmpty)
                        _buildResultRow('Jenis Bilangan: $_numberTypeResult'),
                      if (_cacahResult.isNotEmpty)
                        _buildResultRow('Bilangan Cacah: $_cacahResult'),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
