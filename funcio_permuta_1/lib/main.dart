import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/screens/login_screen.dart';
import 'package:funcio_permuta_1/screens/main_screen.dart';
import 'models/user.dart';
import 'screens/register_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login / Registro de usuarios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final user = settings.arguments as User;
          return MaterialPageRoute(
            builder: (_) => MainPage(user: user),
          );
        }
        return null; // otras rutas no definidas
      },
    );
  }
}
