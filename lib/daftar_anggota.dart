import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class MemberPage extends StatelessWidget {
  final List<Map<String, String>> members = [
    {
      'name': 'Jagad Damai',
      'nim': '123220017',
      'image': 'img/may.jpg',
    },
    {
      'name': 'Sakti Maulana Ibrahim',
      'nim': '123220101',
      'image': 'img/sakti.jpg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: members.asMap().entries.map((entry) {
            int index = entry.key;
            var member = entry.value;

            return FadeInUp(
              delay: Duration(milliseconds: 200 * index),
              duration: const Duration(milliseconds: 800),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          member['image']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 61, 45, 94),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'NIM: ${member['nim']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 81, 62, 100),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
