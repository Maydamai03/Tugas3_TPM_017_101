// lib/pages/tracking_lbs_page.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TrackingLbsPage extends StatefulWidget {
  @override
  _TrackingLbsPageState createState() => _TrackingLbsPageState();
}

class _TrackingLbsPageState extends State<TrackingLbsPage> {
  String _locationMessage = "Menunggu lokasi...";

  // Fungsi untuk meminta izin lokasi dan mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    // Memeriksa izin akses lokasi
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      setState(() {
        _locationMessage = "Akses lokasi ditolak. Coba lagi!";
      });
    } else {
      // Mendapatkan lokasi pengguna
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking LBS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Menampilkan pesan lokasi
            Text(
              _locationMessage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Tombol untuk mendapatkan lokasi
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Dapatkan Lokasi Saat Ini'),
            ),
          ],
        ),
      ),
    );
  }
}
