import 'package:flutter/material.dart';

class JadwalPage extends StatefulWidget {
  final String nama;
  final String npm; 
  final String jurusan;

  const JadwalPage({
    super.key,
    required this.nama,
    required this.npm, 
    required this.jurusan,
  });

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _selectedDay = DateTime.now().weekday;

  final List<String> _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', "Jum'at"];

  // Data Jadwal Kuliah 
  final Map<int, List<Map<String, dynamic>>> _jadwalKuliah = {
    1: [
      {'matkul': 'Data Warehouse & Mining', 'waktu': '07:00-08:40', 'ruang': 'D.1.4', 'sks': 2, 'warna': Colors.blue},
    ],
    2: [
      {'matkul': 'Sistem Basis Data Terdistribusi', 'waktu': '09:40-12:10', 'ruang': 'D.1.2', 'sks': 3, 'warna': Colors.purple},
    ],
    3: [], // Rabu kosong
    4: [
      {'matkul': 'APB & Praktik', 'waktu': '07:00-10:30', 'ruang': 'LK 1.3', 'sks': 3, 'warna': Colors.cyan},
      {'matkul': 'Sistem Tersebar', 'waktu': '12:50-15:20', 'ruang': 'G.2.2', 'sks': 3, 'warna': Colors.teal},
    ],
    5: [
      {'matkul': 'Manajemen Risiko SI', 'waktu': '07:50-09:30', 'ruang': 'E.2.1', 'sks': 2, 'warna': Colors.amber},
    ],
  };

  bool _hasJadwal(int day) => _jadwalKuliah.containsKey(day) && _jadwalKuliah[day]!.isNotEmpty;
  List<Map<String, dynamic>> _getJadwal(int day) => _jadwalKuliah[day] ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Jadwal Kuliah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color.fromARGB(255, 13, 131, 228),
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 135, 200, 246), const Color.fromARGB(255, 179, 217, 237)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center( 
          child: Container(
            width: 950, 
            child: Column(
              children: [
                _buildHeader(),
                _buildDayPicker(),
                const SizedBox(height: 16),
                _buildTitle(),
                const SizedBox(height: 12),
                _buildJadwalList(),
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
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 8), 
      padding: const EdgeInsets.all(16), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 80, 148, 202), 
          width: 1.5,
        ),
        boxShadow: [BoxShadow(color: const Color.fromARGB(255, 23, 130, 218).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.nama, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                const SizedBox(height: 4),
                Text(
                  'NPM: ${widget.npm} | ${widget.jurusan}', 
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600), 
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50, 
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(255, 72, 131, 180), 
                width: 1,
              ),
            ),
            child: const Icon(Icons.calendar_month, color: Colors.blue, size: 24), 
          ),
        ],
      ),
    );
  }

  Widget _buildDayPicker() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 0), 
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            int day = index + 1;
            bool selected = _selectedDay == day;
            bool hasJadwal = _hasJadwal(day);

            return GestureDetector(
              onTap: () => setState(() => _selectedDay = day),
              child: Container(
                width: 70, 
                margin: const EdgeInsets.only(right: 8), 
                decoration: BoxDecoration(
                  color: selected ? Colors.blue : (hasJadwal ? Colors.white : Colors.grey.shade100),
                  borderRadius: BorderRadius.circular(10), 
                  border: Border.all(
                    color: selected ? Colors.blue : (hasJadwal ? Colors.blue.shade300 : Colors.grey.shade300), 
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _hari[index].substring(0, 3),
                      style: TextStyle(
                        color: selected ? Colors.white : (hasJadwal ? Colors.blue.shade800 : Colors.grey.shade500),
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13, 
                      ),
                    ),
                    if (hasJadwal && !selected)
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    int jumlah = _getJadwal(_selectedDay).length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedDay <= 5 ? _hari[_selectedDay - 1] : 'Libur',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), 
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue.shade100, 
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color.fromARGB(255, 73, 131, 178), 
                width: 1,
              ),
            ),
            child: Text(
              '$jumlah Matkul',
              style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 12), 
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalList() {
    List<Map<String, dynamic>> jadwal = _getJadwal(_selectedDay);

    if (jadwal.isEmpty) {
      return Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 75, 126, 168), 
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.weekend, size: 60, color: Colors.grey.shade400), 
                const SizedBox(height: 12),
                Text(
                  _selectedDay > 5 ? 'Hari libur' : 'Tidak ada jadwal',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500), 
                ),
                const SizedBox(height: 6),
                Text('Selamat beristirahat! 🎉', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12), 
        child: Column(
          children: jadwal.map((j) => _buildCard(j)).toList(),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> j) {
    Color warna = j['warna'];
    
    // Parse waktu
    List<String> waktu = j['waktu'].toString().split('-');
    String mulai = waktu.length > 0 ? waktu[0].trim() : '';
    String selesai = waktu.length > 1 ? waktu[1].trim() : '';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12), 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: warna.withOpacity(0.5), 
          width: 1.2,
        ),
        boxShadow: [BoxShadow(color: warna.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0, 
            top: 0, 
            bottom: 0, 
            child: Container(
              width: 6, 
              decoration: BoxDecoration(
                color: warna, 
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), 
                  bottomLeft: Radius.circular(12)
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16), 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Waktu
                Container(
                  width: 75, 
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: warna.withOpacity(0.1), 
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: warna.withOpacity(0.3), 
                      width: 0.8,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        mulai, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold, 
                          color: warna
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        's/d', 
                        style: TextStyle(
                          fontSize: 8, 
                          color: warna.withOpacity(0.6)
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        selesai, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.bold, 
                          color: warna
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12), 
                
                // Detail kuliah
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (j['sks'] > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100, 
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400, 
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            '${j['sks']} SKS', 
                            style: TextStyle(
                              fontSize: 10, 
                              color: Colors.grey.shade700
                            ),
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                        j['matkul'], 
                        style: const TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (j['ruang'] != null && j['ruang'] != '-')
                        Row(
                          children: [
                            Icon(
                              Icons.room, 
                              size: 12, 
                              color: Colors.grey.shade600
                            ),
                            const SizedBox(width: 4),
                            Text(
                              j['ruang'], 
                              style: TextStyle(
                                fontSize: 12, 
                                color: Colors.grey.shade600
                              ),
                            ),
                          ],
                        ),
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
}