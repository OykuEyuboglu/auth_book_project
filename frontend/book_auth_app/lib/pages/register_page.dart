import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> register() async {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || username.isEmpty || password.isEmpty) return;

    setState(() => isLoading = true);

    final url = Uri.parse("https://localhost:7027/api/Auth/register");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "username": username,
        "password": password,
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 201) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(successMessage: "Kayıt başarılı!"),
          ),
        );
      }
    } else {
      final error = jsonDecode(response.body)['error'] ?? "Kayıt başarısız";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kayıt Ol")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Kullanıcı Adı"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Şifre"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : register,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                  Set<MaterialState> states,
                ) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromARGB(255, 192, 192, 192);
                  }
                  return const Color.fromARGB(255, 224, 224, 224);
                }),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}


