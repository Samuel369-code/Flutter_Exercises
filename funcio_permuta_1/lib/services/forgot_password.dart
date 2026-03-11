import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/app_colors.dart';

class ForgotPassword extends StatefulWidget {
  final String? initialEmail; // parámetro opcional para prellenar el email

  const ForgotPassword({Key? key, this.initialEmail}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'El link para restaurar tu contraseña ha sido enviado a tu email.',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // Volver al login
    } on FirebaseAuthException catch (e) {
      String message = 'Ha ocurrido un error';
      if (e.code == 'user-not-found') {
        message = 'Ningún usuario encontrado con este email';
      } else if (e.code == 'invalid-email') {
        message = 'La dirección email no es válida';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
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
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Imagen cabecera
                        Image.asset(
                          'assets/images/Capa_1.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'Introduce tu dirección email y te enviaremos el link para recuperar la contraseña.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Dirección email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor introduce tu email.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                          onPressed: _sendPasswordResetEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Enviar link'),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
      ),
    );
  }
}
