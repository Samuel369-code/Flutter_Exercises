import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/user_repository.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Inicializamos los controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    _nameController.text = prefs.getString('name') ?? 'Admin User';
    _emailController.text = prefs.getString('email') ?? 'admin@example.com';
    _phoneController.text = prefs.getString('phone') ?? '+34 600 123 456';

    final imagePath = prefs.getString('profileImage');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? picked =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (UserRepository.currentUser == null) return;

    final updatedUser = User(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: UserRepository.currentUser!.password,
      profileImagePath: _profileImage?.path ?? UserRepository.currentUser!.profileImagePath,
    );

    UserRepository.updateUser(updatedUser);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/images/Capa_1.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    child: _profileImage != null
                        ? Image.file(_profileImage!, fit: BoxFit.cover)
                        : const Icon(Icons.person, size: 70, color: Colors.grey),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(60),
                      onTap: _pickImage,
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField("Nombre completo", _nameController),
            const SizedBox(height: 20),
            _buildTextField("Correo electronico", _emailController),
            const SizedBox(height: 20),
            _buildTextField("Telefono", _phoneController),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveProfile();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perfil actualitzado correctamente'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Guardar cambios',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
