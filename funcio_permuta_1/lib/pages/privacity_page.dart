import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de privacidad'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                'assets/images/Capa_1.png',
                fit: BoxFit.contain,
              ),
            ),            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Tu privacidad es importante para nosotros. '
                    'La aplicación recopila únicamente los datos necesarios para mejorar tu experiencia. '
                    'Nunca compartiremos tu información personal sin tu consentimiento.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
