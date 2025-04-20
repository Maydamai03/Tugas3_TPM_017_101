import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackingLbsPage extends StatefulWidget {
  @override
  _TrackingLbsPageState createState() => _TrackingLbsPageState();
}

class _TrackingLbsPageState extends State<TrackingLbsPage> {
  String _locationMessage = "Tekan tombol di bawah untuk cek lokasi Anda.";
  LatLng? _currentLatLng;
  final MapController _mapController = MapController();

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      _locationMessage = "Mengecek lokasi...";
    });

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi tidak aktif. Aktifkan GPS.";
      });
      return;
    }

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
            "Izin lokasi ditolak permanen. Aktifkan melalui pengaturan.";
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Lokasi Terkini:\nLatitude: ${position.latitude}\nLongitude: ${position.longitude}";
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              _locationMessage,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.my_location),
              label: Text('Cek Lokasi Anda'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _currentLatLng == null
                  ? Center(
                      child: Text('Peta akan muncul setelah lokasi diperoleh.'),
                    )
                  : FlutterMap(
                      mapController: _mapController,
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
