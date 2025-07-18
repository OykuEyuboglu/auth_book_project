import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'book_list_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    bool success = await AuthService()
        .login(_emailController.text.trim(), _passwordController.text.trim());

    setState(() {
      _loading = false;
    });

    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => BookListPage()));
    } else {
      setState(() {
        _errorMessage = "Login failed. Please check credentials.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: "Email", border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration:
                  InputDecoration(labelText: "Password", border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 12),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text("Login"),
                  ),
            if (_errorMessage != null) ...[
              SizedBox(height: 12),
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
