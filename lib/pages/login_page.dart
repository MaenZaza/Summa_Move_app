import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  final emailCtl = TextEditingController();
  final pwCtl = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

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
            TextField(controller: pwCtl, decoration: const InputDecoration(labelText: 'Wachtwoord'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool ok = await AuthService.login(emailCtl.text, pwCtl.text);
                if (ok) {
                  Navigator.pushReplacementNamed(context, '/oefeningen');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login mislukt')));
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