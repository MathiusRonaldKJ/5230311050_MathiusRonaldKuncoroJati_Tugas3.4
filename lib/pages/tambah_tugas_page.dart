import 'package:flutter/material.dart';

class TambahTugasPage extends StatefulWidget {
  final Function(Map<String, String>) onTambahTugas; 

  const TambahTugasPage({
    super.key,
    required this.onTambahTugas,
  });

  @override
  State<TambahTugasPage> createState() => _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  final _formKey = GlobalKey<FormState>();
  final _matkulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _deadlineController = TextEditingController();

  final List<String> _rekomendasiMatkul = [
    'Aplikasi Perangkat Bergerak',
    'Data Warehouse',
    'Manajemen Risiko SI',
    'Sistem Tersebar',
    'Sistem Basis Data Terdistribusi',
    'Pemrograman Web',
    'Basis Data',
    'IMK',
  ];

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 23, 130, 218),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _deadlineController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _simpanTugas() {
    if (_formKey.currentState!.validate()) {
      final tugasBaru = {
        'matkul': _matkulController.text,
        'deskripsi': _deskripsiController.text,
        'deadline': _deadlineController.text,
      };
      
      widget.onTambahTugas(tugasBaru);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tugas "${_matkulController.text}" ditambahkan'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
        ),
      );
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 226, 254),
      appBar: AppBar(
        title: const Text('Tambah Tugas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color.fromARGB(255, 0, 72, 255),
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
            colors: [const Color.fromARGB(255, 106, 191, 252), const Color.fromARGB(255, 164, 226, 254)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              width: 450, 
              padding: const EdgeInsets.all(20), 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header 
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 60, 
                            height: 60, 
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color.fromARGB(255, 33, 150, 243), Color.fromARGB(255, 3, 169, 244)],
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.note_add,
                                size: 30, 
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16), 

                    const Center(
                      child: Text(
                        'Tambah Tugas Baru',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4), 

                    const Center(
                      child: Text(
                        'Isi data tugas dengan lengkap',
                        style: TextStyle(
                          fontSize: 12, 
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), 

                    // Field Mata Kuliah
                    const Text(
                      'Mata Kuliah',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _matkulController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: APB',
                        hintStyle: const TextStyle(fontSize: 13),
                        prefixIcon: const Icon(Icons.book, color: Colors.blue, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), 
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, 
                          vertical: 12, 
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty) ? 'Mata kuliah harus diisi' : null,
                    ),

                    const SizedBox(height: 6),

                    // Rekomendasi mata kuliah 
                    SizedBox(
                      height: 36, 
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _rekomendasiMatkul.map((matkul) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: FilterChip(
                                label: Text(matkul, style: const TextStyle(fontSize: 11)),
                                onSelected: (selected) {
                                  if (selected) setState(() => _matkulController.text = matkul);
                                },
                                backgroundColor: Colors.grey.shade100,
                                selectedColor: Colors.blue.shade100,
                                checkmarkColor: Colors.blue,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Field Deskripsi
                    const Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _deskripsiController,
                      maxLines: 2, 
                      decoration: InputDecoration(
                        hintText: 'Jelaskan detail tugas...',
                        hintStyle: const TextStyle(fontSize: 13),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Icon(Icons.description, color: Colors.blue, size: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      validator: (value) => (value == null || value.isEmpty) ? 'Deskripsi harus diisi' : null,
                    ),

                    const SizedBox(height: 16),

                    // Field Deadline
                    const Text(
                      'Deadline',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _deadlineController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: 'Pilih tanggal',
                        hintStyle: const TextStyle(fontSize: 13),
                        prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.event, color: Colors.blue, size: 20),
                          onPressed: () => _selectDate(context),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      validator: (value) => (value == null || value.isEmpty) ? 'Deadline harus diisi' : null,
                    ),

                    const SizedBox(height: 20),

                    // Tombol Simpan 
                    SizedBox(
                      width: double.infinity,
                      height: 45, 
                      child: ElevatedButton(
                        onPressed: _simpanTugas,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 7, 132, 235),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'SIMPAN TUGAS',
                          style: TextStyle(
                            fontSize: 14, 
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tombol Batal
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 103, 103),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _matkulController.dispose();
    _deskripsiController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }
}
