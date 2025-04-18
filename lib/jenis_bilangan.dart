// lib/pages/jenis_bilangan_page.dart
import 'package:flutter/material.dart';

class JenisBilanganPage extends StatefulWidget {
  @override
  _JenisBilanganPageState createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  TextEditingController _controller = TextEditingController();
  String _result = '';
  String _selectedType = 'Prima';

  // Mengecek apakah angka adalah bilangan prima
  bool _isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  // Menentukan jenis bilangan (Bulat Positif, Negatif, Cacah)
  String _getNumberType(int number) {
    if (number > 0) {
      return 'Bulat Positif';
    } else if (number < 0) {
      return 'Bulat Negatif';
    } else {
      return 'Cacah';
    }
  }

  // Menentukan apakah input adalah bilangan desimal
  bool _isDecimal(String value) {
    return value.contains('.');
  }

  void _checkNumber() {
    setState(() {
      _result = '';
      String inputText = _controller.text;

      if (inputText.isEmpty) {
        _result = 'Masukkan angka terlebih dahulu!';
        return;
      }

      double inputValue = double.tryParse(inputText) ?? 0;
      int intValue = inputValue.toInt();

      switch (_selectedType) {
        case 'Prima':
          if (_isPrime(intValue)) {
            _result = '$intValue adalah bilangan Prima';
          } else {
            _result = '$intValue bukan bilangan Prima';
          }
          break;
        case 'Decimal':
          if (_isDecimal(inputText)) {
            _result = '$inputText adalah bilangan Decimal';
          } else {
            _result = '$inputText bukan bilangan Decimal';
          }
          break;
        case 'Bulat Positif/Negatif':
          _result = 'Jenis Bilangan: ${_getNumberType(intValue)}';
          break;
        case 'Cacah':
          if (intValue >= 0) {
            _result = '$intValue adalah bilangan Cacah';
          } else {
            _result = '$intValue bukan bilangan Cacah';
          }
          break;
        default:
          _result = 'Pilih jenis bilangan terlebih dahulu';
      }
    });
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
            // Dropdown untuk memilih jenis bilangan
            DropdownButton<String>(
              value: _selectedType,
              items: [
                'Prima',
                'Decimal',
                'Bulat Positif/Negatif',
                'Cacah'
              ].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                  _result = ''; // Reset result ketika jenis bilangan diubah
                });
              },
            ),
            SizedBox(height: 20),

            // Input field untuk angka
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Tombol untuk mengecek jenis bilangan
            ElevatedButton(
              onPressed: _checkNumber,
              child: Text('Cek Jenis Bilangan'),
            ),
            SizedBox(height: 20),

            // Menampilkan hasil
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
