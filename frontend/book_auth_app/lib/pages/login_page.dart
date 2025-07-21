import 'package:flutter/material.dart'; 
import '../services/auth_service.dart';
import 'book_list_page.dart';
import 'register_page.dart';

class HoverText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverText({required this.text, required this.onTap, Key? key})
    : super(key: key);

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovering
                ? Colors.blue[400]
                : const Color.fromARGB(255, 0, 10, 100),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String? successMessage;

  const LoginPage({Key? key, this.successMessage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  bool _showSuccessMessage = false;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    if (widget.successMessage != null) {
      _showSuccessMessage = true;
      _startFadeOutAnimation();
    }
  }

  void _startFadeOutAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _opacity = 0);
    }
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _showSuccessMessage = false;
        _opacity = 1.0;
      });
    }
  }

  void _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    bool success = await AuthService().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BookListPage()),
      );
    } else {
      setState(() {
        _errorMessage = "Login failed. Please check credentials.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("Login"),
                      ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabınız yok mu? "),
                    HoverText(
                      text: "Kayıt Ol",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showSuccessMessage)
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.green.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      widget.successMessage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}