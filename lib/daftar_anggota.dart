// lib/pages/member_page.dart
import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  // Daftar anggota yang akan ditampilkan
  final List<Map<String, String>> members = [
    {
      'name': 'Anggota 1',
      'role': 'Admin',
      'image':
          'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Anggota 2',
      'role': 'Member',
      'image':
          'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'name': 'Anggota 3',
      'role': 'Member',
      'image':
          'https://randomuser.me/api/portraits/men/3.jpg',
    },
    {
      'name': 'Anggota 4',
      'role': 'Member',
      'image':
          'https://randomuser.me/api/portraits/women/4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          var member = members[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(member['image'] ?? ''),
              ),
              title: Text(member['name'] ?? 'Nama Anggota'),
              subtitle: Text('Peran: ${member['role']}'),
            ),
          );
        },
      ),
    );
  }
}
