// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtl = TextEditingController();
  final pwCtl = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailCtl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(
              controller: pwCtl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() => _loading = true);
                bool ok = await AuthService.login(emailCtl.text, pwCtl.text);
                setState(() => _loading = false);
                if (ok) {
                  Navigator.pushReplacementNamed(context, '/oefeningen');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login mislukt')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
