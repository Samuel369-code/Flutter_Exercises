import 'package:flutter/material.dart';
import '../models/user.dart';
import '../pages/productos_page.dart';
import '../pages/historial_page.dart';
import '../pages/carrito_page.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const ProductosPage(),
      const HistorialPage(),
      CarritoPage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }
}
