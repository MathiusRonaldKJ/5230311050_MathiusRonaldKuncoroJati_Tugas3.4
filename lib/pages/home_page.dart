import 'package:flutter/material.dart';
import 'login_page.dart';
import 'jadwal_page.dart';
import 'tambah_tugas_page.dart';

class HomePage extends StatefulWidget {
  final String nama;
  final String npm; 
  final String jurusan;

  const HomePage({
    super.key,
    required this.nama,
    required this.npm, 
    required this.jurusan,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // data tugas 
  final Map<String, List<Map<String, String>>> _tugas = {
    'aktif': [
      {
        'matkul': 'Aplikasi Perangkat Bergerak',
        'deskripsi': 'Membuat Aplikasi Flutter',
        'deadline': '2026-03-10',
      },
      {
        'matkul': 'Data Warehouse',
        'deskripsi': 'Membuat Essay Data Warehouse',
        'deadline': '2026-03-01',
      },
      {
        'matkul': 'Manajemen Risiko SI',
        'deskripsi': 'Essay Manajemen Risiko',
        'deadline': '2026-03-04',
      },
    ],
    'selesai': [
      {
        'matkul': 'Sistem Tersebar',
        'deskripsi': 'Artikel Sistem Tersebar',
        'deadline': '2026-02-26',
      },
      {
        'matkul': 'Sistem Basis Data Terdistribusi',
        'deskripsi': 'Perbandingan Tersebar & Terdistribusi',
        'deadline': '2026-02-24',
      },
    ],
  };

  List<Map<String, String>> get _tugasAktif => _tugas['aktif']!;
  List<Map<String, String>> get _tugasSelesai => _tugas['selesai']!;

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _tambahTugas(Map<String, String> tugasBaru) {
    setState(() => _tugasAktif.add(tugasBaru));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas "${tugasBaru['matkul']}" ditambahkan'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TugasKu', style: TextStyle(fontSize: 18)),
        backgroundColor: const Color.fromARGB(255, 16, 127, 217),
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, size: 22),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 8)),
                ),
              ),
            ],
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, size: 22),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _logout,
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.red, size: 18),
                    SizedBox(width: 6),
                    Text('Logout', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          const SizedBox.shrink(),
          _buildProfileContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JadwalPage(
                  nama: widget.nama,
                  npm: widget.npm, 
                  jurusan: widget.jurusan,
                ),
              ),
            ).then((_) {
              if (mounted) setState(() => _selectedIndex = 0);
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 20), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month, size: 20), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 20), label: 'Profil'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 11),
      ),
    );
  }

  Widget _buildHomeContent() {
    int aktif = _tugasAktif.length;
    int selesai = _tugasSelesai.length;
    int total = aktif + selesai;
    double progress = total > 0 ? selesai / total : 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 135, 200, 246), const Color.fromARGB(255, 156, 195, 218)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align( 
        alignment: const Alignment(0.1, 0), 
        child: Container(
          width: 950, 
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildRingkasan(aktif, selesai, total, progress),
                const SizedBox(height: 16),
                _buildSectionTugas('Tugas Aktif', aktif, _tugasAktif, true),
                const SizedBox(height: 16),
                _buildSectionTugas('Riwayat Selesai', selesai, _tugasSelesai, false),
                const SizedBox(height: 16),
                _buildTombolTambah(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    int total = _tugasAktif.length + _tugasSelesai.length;
    double progress = total > 0 ? _tugasSelesai.length / total : 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 135, 200, 246), const Color.fromARGB(255, 127, 182, 211)], 
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align( 
        alignment: const Alignment(0.1, 0), 
        child: Container(
          width: 950,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10)],
                      ),
                      child: const Center(child: Text('📚', style: TextStyle(fontSize: 45))),
                    ),
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(widget.nama, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.jurusan, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildProfileStatCard(Icons.assignment, 'Total', '$total', const Color.fromARGB(255, 252, 81, 81)),
                    const SizedBox(width: 10),
                    _buildProfileStatCard(Icons.check_circle, 'Selesai', '${_tugasSelesai.length}', Colors.green),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildProfileStatCard(Icons.percent, 'Progress', '${(progress * 100).toInt()}%', Colors.orange),
                    const SizedBox(width: 10),
                    _buildProfileStatCard(Icons.stars, 'Poin', '0', Colors.purple),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoContainer(),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 15),
                  label: const Text('Edit Profil', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: Colors.blue.shade200),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selamat Datang,', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(widget.nama, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('NPM: ${widget.npm}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
            child: const Icon(Icons.person, size: 30, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasan(int aktif, int selesai, int total, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ringkasan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildStatCard(Icons.assignment, 'Tugas Aktif', '$aktif', const Color.fromARGB(255, 250, 58, 58)),
            const SizedBox(width: 10),
            _buildStatCard(Icons.check_circle, 'Selesai', '$selesai', Colors.green),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Progress Tugas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text('$selesai/$total selesai', style: TextStyle(color: Colors.blue.shade700, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 6),
              Stack(
                children: [
                  Container(height: 6, decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(3))),
                  Container(
                    height: 6,
                    width: 350 * progress, 
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.blue, Colors.lightBlue]),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTugas(String title, int count, List<Map<String, String>> tugas, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isActive ? const Color.fromARGB(255, 241, 169, 169) : Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count tugas',
                style: TextStyle(
                  color: isActive ? const Color.fromARGB(255, 198, 30, 30) : Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (tugas.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(16), child: Text('Tidak ada tugas', style: TextStyle(fontSize: 13))))
        else
          ...tugas.map((t) => _buildTugasCard(t['matkul']!, t['deskripsi']!, t['deadline']!, isActive)),
      ],
    );
  }

  Widget _buildTugasCard(String matkul, String deskripsi, String deadline, bool isActive) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isActive ? Colors.blue.shade200 : Colors.green.shade200, width: 0.8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? Colors.blue.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(isActive ? Icons.assignment : Icons.check_circle, color: isActive ? Colors.blue : Colors.green, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  matkul,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    decoration: isActive ? null : TextDecoration.lineThrough,
                    color: isActive ? Colors.black : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 11,
                    color: isActive ? Colors.grey.shade600 : Colors.grey.shade500,
                    decoration: isActive ? null : TextDecoration.lineThrough,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.red.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today, size: 9, color: isActive ? Colors.red.shade400 : Colors.grey.shade500),
                      const SizedBox(width: 3),
                      Text(deadline, style: TextStyle(fontSize: 9, color: isActive ? Colors.red.shade400 : Colors.grey.shade500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTombolTambah() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahTugasPage(onTambahTugas: _tambahTugas),
            ),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white, size: 16),
        label: const Text('Tambah Tugas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 2,
        ),
      ),
    );
  }

  Widget _buildProfileStatCard(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informasi Pribadi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.person, 'Nama', widget.nama),
          const Divider(height: 12),
          _buildInfoRow(Icons.card_membership, 'NPM', widget.npm), 
          const Divider(height: 12),
          _buildInfoRow(Icons.school, 'Jurusan', widget.jurusan),
          const Divider(height: 12),
          _buildInfoRow(Icons.email, 'Email', '${widget.npm}@student.ac.id'), 
          const Divider(height: 12),
          _buildInfoRow(Icons.phone, 'No. HP', '0812-xxxx-xxxx'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, color: Colors.blue, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                const SizedBox(height: 1),
                Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}