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
  String _time = '00:00:00';
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
  }

  // Update time setiap detik
  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _time = _formatDuration(_stopwatch.elapsed);
      });
    }
  }

  // Format durasi waktu
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}';
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

  // Reset stopwatch
  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _time = '00:00:00';
      _isRunning = false;
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
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
