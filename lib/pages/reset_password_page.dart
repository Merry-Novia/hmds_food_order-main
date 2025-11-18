import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  // Fungsi Reset Password
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      final email = emailCtrl.text.trim();
      final newPass = newPassCtrl.text.trim();

      // Di aplikasi nyata → kirim request ke API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password untuk $email berhasil diperbarui!"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // kembali ke login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EE),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Reset Password"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color(0xFF1C1B1F),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ==== Judul ====
                    const Text(
                      "Reset Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ==== Email ====
                    TextFormField(
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white10,
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Masukkan email";
                        }
                        if (!v.contains("@")) {
                          return "Email tidak valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ==== Password baru ====
                    TextFormField(
                      controller: newPassCtrl,
                      decoration: const InputDecoration(
                        labelText: "Password Baru",
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white10,
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (v) =>
                      (v == null || v.isEmpty) ? "Masukkan password baru" : null,
                    ),
                    const SizedBox(height: 16),

                    // ==== Konfirmasi ====
                    TextFormField(
                      controller: confirmPassCtrl,
                      decoration: const InputDecoration(
                        labelText: "Konfirmasi Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white10,
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Masukkan konfirmasi password";
                        }
                        if (v != newPassCtrl.text.trim()) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    // ==== Tombol Reset ====
                    ElevatedButton(
                      onPressed: _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "RESET PASSWORD",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ==== Tombol kembali ====
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Kembali ke Login",
                        style: TextStyle(color: Colors.orangeAccent),
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
}
