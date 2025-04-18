// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:tugas3_tpm/daftar_anggota.dart';
import 'main_menu.dart';
import 'help_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MainMenu(), // Halaman utama dengan 5 menu
    MemberPage(), // Halaman Daftar Anggota
    HelpPage(), // Halaman Bantuan
  ];

  final List<String> _titles = [
    'Beranda',
    'Daftar Anggota',
    'Bantuan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 8),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Anggota',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_rounded),
              label: 'Bantuan',
            ),
          ],
        ),
      ),
    );
  }
}