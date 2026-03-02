import 'package:flutter/material.dart';
import 'home_page.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _npmController = TextEditingController();
  final _jurusanController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 165, 252),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Stack(
                  children: [
                    Container(
                      width: 100, 
                      height: 100, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.school,
                          size: 50, 
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Judul
                const Text(
                  'TugasKu',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Aplikasi Catatan Tugas & Jadwal Kuliah',
                  style: TextStyle(
                    fontSize: 14, 
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30), 

                Center(
                  child: Container(
                    width: 400, 
                    padding: const EdgeInsets.all(20), 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16), 
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login Mahasiswa',
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 16), 

                          // Field Nama
                          const Text(
                            'Nama Lengkap',
                            style: TextStyle(fontSize: 13), 
                          ),
                          const SizedBox(height: 6), 
                          TextFormField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama',
                              hintStyle: const TextStyle(fontSize: 13),
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.blue, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8), 
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12, 
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama harus diisi';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12), 

                          // Field NPM
                          const Text(
                            'NPM',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _npmController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan NPM',
                              hintStyle: const TextStyle(fontSize: 13),
                              prefixIcon: const Icon(Icons.card_membership,
                                  color: Colors.blue, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'NPM harus diisi';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),

                          // Field Jurusan
                          const Text(
                            'Jurusan',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _jurusanController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan jurusan',
                              hintStyle: const TextStyle(fontSize: 13),
                              prefixIcon:
                                  const Icon(Icons.book, color: Colors.blue, size: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Jurusan harus diisi';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),

                          // Field Password
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Masukkan password',
                              hintStyle: const TextStyle(fontSize: 13),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.blue, size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password harus diisi';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16), 

                          // Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _isAgreed,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgreed = value ?? false;
                                  });
                                },
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, 
                              ),
                              Expanded(
                                child: Text(
                                  'Saya setuju dengan syarat dan ketentuan',
                                  style: TextStyle(
                                      fontSize: 11, 
                                      color: Colors.grey.shade600),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16), 

                          // Tombol Login
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.blueAccent],
                                    ),
                                    borderRadius: BorderRadius.circular(8), 
                                  ),
                                ),
                                Positioned.fill(
                                  child: ElevatedButton(
                                    onPressed: _isAgreed
                                        ? () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Kirim data ke HomePage
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => HomePage(
                                                    nama: _namaController.text,
                                                    npm: _npmController.text,
                                                    jurusan:
                                                        _jurusanController.text,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 14, 
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _npmController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }
}
