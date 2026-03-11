import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/core/app_colors.dart';
import 'package:funcio_permuta_1/services/user_repository.dart';
import '../services/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryLogin() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final user = UserRepository.authenticate(email, password);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, '/home', arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/login-checkout_bg_img.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/Capa_1.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Introduce el email';
                            if (!v.contains('@')) return 'Email inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Introduce la contraseña';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgotPassword(
                                    initialEmail: _emailController.text.trim(),
                                  ),
                                ),
                              );
                            },
                            child: const Text('¿Olvidaste tu contraseña?'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _tryLogin,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.button),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Text('Iniciar sesión'),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                          child: const Text('¿No tienes cuenta? Regístrate'),
                        ),
                      ],
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
