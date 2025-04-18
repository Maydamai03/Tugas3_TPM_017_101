// lib/pages/situs_rekomendasi_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SitusRekomendasiPage extends StatefulWidget {
  @override
  _SitusRekomendasiPageState createState() => _SitusRekomendasiPageState();
}

class _SitusRekomendasiPageState extends State<SitusRekomendasiPage> {
  // Daftar situs rekomendasi
  List<Map<String, String>> _sites = [
    {
      'name': 'Flutter',
      'url': 'https://flutter.dev',
      'image': 'https://flutter.dev/assets/homepage/carousel/slide_1-bg-4e74b66e45fbcd0e0b50561e34627ef88d5b3c3796a17f9f52098c17c47d7a58.png',
    },
    {
      'name': 'Dart',
      'url': 'https://dart.dev',
      'image': 'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
    },
    {
      'name': 'Google',
      'url': 'https://www.google.com',
      'image': 'https://www.google.com/images/branding/googlelogo/1x/googlelogo-32x32.png',
    },
  ];

  // Fungsi untuk membuka link situs
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situs Rekomendasi'),
      ),
      body: ListView.builder(
        itemCount: _sites.length,
        itemBuilder: (context, index) {
          var site = _sites[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(site['image'] ?? '', width: 50, height: 50),
              title: Text(site['name'] ?? 'Nama Situs'),
              subtitle: Text(site['url'] ?? 'URL Situs'),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Aksi favorit (tandai sebagai favorit)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${site['name']} telah ditandai sebagai favorit!')),
                  );
                },
              ),
              onTap: () => _launchURL(site['url'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
