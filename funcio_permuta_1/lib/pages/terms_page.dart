import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y condiciones'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100, // ajusta el alto a tu gusto
              child: Image.asset(
                'assets/images/Capa_1.png',
                fit: BoxFit.contain, // o BoxFit.cover si quieres que llene el espacio
              ),
            ),            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Estos son los términos y condiciones de uso de la aplicación. '
                    'Al utilizar este servicio aceptas nuestras políticas y el correcto uso de la plataforma.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
