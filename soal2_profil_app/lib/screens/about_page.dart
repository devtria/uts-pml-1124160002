import 'package:flutter/material.dart';
import '../widgets/info_tile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Saya'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Keahlian & Hobi',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const InfoTile(
            icon: Icons.code,
            label: 'Pengembangan Flutter & Dart',
            value: 'Membangun aplikasi mobile.',
          ),
          const InfoTile(
            icon: Icons.web,
            label: 'Web Development',
            value: 'Menguasai HTML, CSS, JavaScript, PHP, dan Laravel.',
          ),
          const InfoTile(
            icon: Icons.sports_esports,
            label: 'Hobi',
            value: 'Mengembangkan Web, dan gaming.',
          ),
          const SizedBox(height: 24),
          Text(
            'Riwayat Pendidikan',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const InfoTile(
            icon: Icons.school,
            label: 'S1 Teknik Informatika',
            value: 'Institut Teknologi & Bisnis Bina Sarana Global (2024 - Sekarang)',
          ),
          const InfoTile(
            icon: Icons.history_edu,
            label: 'SMA / Sederajat',
            value: 'Sekolah Menengah Atas (Lulus 2024)',
          ),
        ],
      ),
    );
  }
}