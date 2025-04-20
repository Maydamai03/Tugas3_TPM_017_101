// lib/pages/stopwatch_page.dart
import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _time = '00:00:00,00'; // Ubah nilai awal ke format yang diinginkan
  bool _isRunning = false;
  List<String> _laps = []; // List untuk menyimpan lap times
  Duration _lastLapTime = Duration.zero; // Waktu lap terakhir

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(
        Duration(milliseconds: 10), _updateTime); // Interval lebih cepat
  }

  // Update time setiap 10 milidetik
  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _time = _formatDuration(_stopwatch.elapsed);
      });
    }
  }

  // Format durasi waktu dengan milidetik
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    int milliseconds =
        (duration.inMilliseconds % 1000) ~/ 10; // Ambil 2 digit milidetik
    return '${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)},${_pad(milliseconds)}';
  }

  // Menambahkan angka 0 jika bilangan kurang dari 10
  String _pad(int value) {
    return value.toString().padLeft(2, '0');
  }

  // Mulai atau hentikan stopwatch
  void _toggleStopwatch() {
    setState(() {
      if (_isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _isRunning = !_isRunning;
    });
  }

  // Tambahkan waktu lap
  void _addLap() {
    setState(() {
      final currentLapTime =
          _stopwatch.elapsed - _lastLapTime; // Hitung selisih waktu lap
      _laps.add(_formatDuration(currentLapTime)); // Tambahkan waktu lap ke list
      _lastLapTime = _stopwatch.elapsed; // Perbarui waktu lap terakhir
    });
  }

  // Reset stopwatch
  void _resetStopwatch() {
    setState(() {
      _stopwatch.stop(); // Hentikan stopwatch
      _stopwatch.reset(); // Reset stopwatch
      _time = '00:00:00,00'; // Set waktu ke format awal
      _isRunning = false; // Set status ke tidak berjalan
      _laps.clear(); // Hapus semua lap times
      _lastLapTime = Duration.zero; // Reset waktu lap terakhir
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Membatalkan timer saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _time,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleStopwatch,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRunning
                      ? _addLap
                      : _resetStopwatch, // Lap saat berjalan, Reset saat berhenti
                  child: Text(_isRunning ? 'Lap' : 'Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_laps.isNotEmpty) ...[
              Text(
                'Lap Times:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _laps.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Lap ${index + 1}: ${_laps[index]}'),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
