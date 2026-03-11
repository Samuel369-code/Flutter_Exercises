import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funcio_permuta_1/models/user.dart';
import 'package:funcio_permuta_1/pages/info_page.dart';
import 'package:funcio_permuta_1/pages/privacity_page.dart';
import 'package:funcio_permuta_1/pages/terms_page.dart';

import '../core/app_colors.dart';
import '../pages/change_password_page.dart';
import '../pages/edit_profile_page.dart';
import '../services/user_repository.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String userEmail = 'admin@example.com';
    const String userPhone = '+34 600 123 456';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Capa_1.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 3),
                    ),
                    child: ClipOval(
                      child: (UserRepository.currentUser?.profileImagePath != null &&
                          UserRepository.currentUser!.profileImagePath!.isNotEmpty)
                          ? Image.file(
                        File(UserRepository.currentUser!.profileImagePath!),
                        fit: BoxFit.cover,
                      )
                          : const Image(
                        image: AssetImage('assets/images/profile_placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/Star_1.png',
                        width: 120, // igual que el contenedor circular
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),

              const Text(
                'MAIL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                userEmail,
                style: const TextStyle(color: Colors.black87, fontSize: 15),
              ),
              const SizedBox(height: 10),
              const Text(
                'MÓVIL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                userPhone,
                style: const TextStyle(color: Colors.black87, fontSize: 15),
              ),
              const SizedBox(height: 30),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/image_4.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 6 * 60, // 6 botones * 60px de alto aprox
                        fit: BoxFit.fill,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildProfileButton(
                            icon: Icons.edit,
                            text: 'Editar perfil',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const EditProfilePage()),
                              );
                            },
                          ),
                          _buildProfileButton(
                            icon: Icons.lock_outline,
                            text: 'Cambiar contraseña',
                            onTap: () {
                              final user = UserRepository.currentUser;
                              if (user == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('No hay usuario logueado')),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordPage(user: user),
                                ),
                              );
                            },
                          ),
                          _buildProfileButton(
                            icon: Icons.gavel,
                            text: 'Términos y condiciones',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsPage(),
                                ),
                              );
                            },
                          ),
                          _buildProfileButton(
                            icon: Icons.shield,
                            text: 'Política de privacidad',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPage(),
                                ),
                              );
                            },
                          ),
                          _buildProfileButton(
                            icon: Icons.info_outline,
                            text: 'Información',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoPage()
                                ),
                              );
                            },
                          ),
                          _buildProfileButton(
                            icon: Icons.logout,
                            text: 'Cerrar sesión',
                            onTap: () {
                              UserRepository.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                    (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.black),
        label: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          alignment: Alignment.centerLeft,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
      ),
    );
  }
}

