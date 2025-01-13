import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("img/pp.png"),
                ),
                SizedBox(height: 10),
                Text(
                  'Risma Bidayatul Hidayah',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '21670015',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // Expanded digunakan untuk memperluas ListView agar mengisi ruang kosong yang tersisa.
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: const [
                ProfileItem(
                  icon: Icons.add_task_outlined,
                  title: 'Kelas',
                  subtitle: '5 B',
                ),
                ProfileItem(
                  icon: Icons.add_task_outlined,
                  title: 'Mata Kuliah',
                  subtitle: 'Mobile Programming',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon; // Ikon untuk item profil.
  final String title; // Judul item profil.
  final String subtitle; // Subtitle item profil.

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Memberikan padding vertikal untuk jarak.
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }
}
