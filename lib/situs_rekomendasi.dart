import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../sites_data.dart'; // Import file data situs

class SitusRekomendasiPage extends StatefulWidget {
  @override
  _SitusRekomendasiPageState createState() => _SitusRekomendasiPageState();
}

class _SitusRekomendasiPageState extends State<SitusRekomendasiPage> {
  List<Map<String, String>> _sites = List.from(sites); // Copy agar bisa dimodifikasi
  Set<String> _favoriteUrls = {}; // Simpan yang sudah favorit pakai URL
  final ScrollController _scrollController = ScrollController();

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      String url = _sites[index]['url'] ?? '';
      bool isFav = _favoriteUrls.contains(url);

      if (isFav) {
        _favoriteUrls.remove(url);
      } else {
        _favoriteUrls.add(url);
        // Pindahkan item ke paling atas
        final item = _sites.removeAt(index);
        _sites.insert(0, item);

        // Scroll ke atas biar kelihatan
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item['name']} ditandai sebagai favorit!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situs Rekomendasi'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _sites.length,
        itemBuilder: (context, index) {
          var site = _sites[index];
          bool isFav = _favoriteUrls.contains(site['url']);

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(site['image'] ?? '', width: 50, height: 50),
              title: Text(site['name'] ?? 'Nama Situs'),
              subtitle: Text(site['url'] ?? 'URL Situs'),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () => _toggleFavorite(index),
              ),
              onTap: () => _launchURL(site['url'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
