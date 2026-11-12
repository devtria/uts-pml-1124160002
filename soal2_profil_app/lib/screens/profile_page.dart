import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../widgets/info_tile.dart';
import 'edit_profile_page.dart';
import 'about_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final ThemeMode currentThemeMode;

  const ProfilePage({
    Key? key,
    required this.onThemeChanged,
    required this.currentThemeMode,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Inisialisasi data awal profil
  Profile _profile = Profile(
    name: 'Nama Lengkap Anda',
    nim: '1124160002',
    prodi: 'Teknik Informatika',
    kelas: 'TI 4.1',
    email: 'emailanda@student.global.ac.id',
    phone: '081234567890',
    github: 'github.com/devtria',
    bio: 'Mahasiswa aktif Program Studi Teknik Informatika yang tertarik pada pengembangan aplikasi mobile.',
  );

  // Fungsi untuk membuka halaman edit dan menerima data kembali
  void _navigateToEditProfile() async {
    final updatedProfile = await Navigator.push<Profile>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(currentProfile: _profile),
      ),
    );

    // Jika data baru dikembalikan, perbarui state halaman profil
    if (updatedProfile != null) {
      setState(() {
        _profile = updatedProfile;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.currentThemeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        actions: [
          // Switch/Tombol Mode Gelap langsung di aplikasi
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              widget.onThemeChanged(!isDarkMode);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_profile.name),
              accountEmail: Text(_profile.email),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang Saya'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onThemeChanged: widget.onThemeChanged,
                      currentThemeMode: widget.currentThemeMode,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto Profil dari Assets
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 16),
              
              // Nama Lengkap
              Text(
                _profile.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              
              // NIM & Prodi
              Text(
                'NIM: ${_profile.nim} | ${_profile.prodi}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              
              // Bio Singkat
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _profile.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Navigasi ke Halaman Edit Profil
              ElevatedButton.icon(
                onPressed: _navigateToEditProfile,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
              ),
              const SizedBox(height: 20),

              // Kartu Informasi Kontak
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informasi Kontak',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              InfoTile(icon: Icons.email, label: 'Email', value: _profile.email),
              InfoTile(icon: Icons.phone, label: 'Nomor HP', value: _profile.phone),
              InfoTile(icon: Icons.school, label: 'Kelas', value: _profile.kelas),
              InfoTile(icon: Icons.code, label: 'GitHub', value: _profile.github),
            ],
          ),
        ),
      ),
      // Komponen Scaffold Tambahan: Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
        child: const Icon(Icons.arrow_forward),
        tooltip: 'Lihat Tentang Saya',
      ),
    );
  }
}