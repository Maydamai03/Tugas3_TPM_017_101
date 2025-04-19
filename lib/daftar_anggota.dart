import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  // Daftar anggota yang akan ditampilkan
  final List<Map<String, String>> members = [
    {
      'name': 'Jagad Damai',
      'nim': '123220017',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Sakti Maulana Ibrahim',
      'nim': '123220101',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            var member = members[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(member['image'] ?? ''),
                ),
                title: Text(
                  member['name'] ?? 'Nama',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(
                        255, 81, 62, 100), 
                  ),
                ),
                subtitle: Text(
                  'NIM: ${member['nim']}',
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 81, 62, 100), 
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
