import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackingLbsPage extends StatefulWidget {
  @override
  _TrackingLbsPageState createState() => _TrackingLbsPageState();
}

class _TrackingLbsPageState extends State<TrackingLbsPage> {
  String _locationMessage = "Menunggu lokasi...";
  LatLng? _currentLatLng; // Tambahkan untuk menyimpan koordinat lokasi
  final MapController _mapController =
      MapController(); // Tambahkan MapController

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Panggil fungsi untuk mendapatkan lokasi saat widget diinisialisasi
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi tidak aktif. Silakan aktifkan GPS.";
      });
      return;
    }

    // Cek dan minta izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            "Izin lokasi ditolak permanen. Aktifkan dari pengaturan.";
      });
      return;
    }

    try {
      // Ambil lokasi dengan akurasi tinggi
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Lokasi Terkini:\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}";
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });

// Pindahkan map setelah frame build selesai
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(_currentLatLng!, 15.0);
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Gagal mendapatkan lokasi: $e";
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
            Text(
              _locationMessage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Tambahkan widget peta
            Expanded(
              child: _currentLatLng == null
                  ? Center(
                      child: Text('Peta akan muncul setelah lokasi diperoleh'))
                  : FlutterMap(
                      mapController: _mapController, // Tambahkan MapController
                      options: MapOptions(
                        center: _currentLatLng,
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLatLng!,
                              width: 80,
                              height: 80,
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
