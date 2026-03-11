import 'dart:io';
import 'package:flutter/material.dart';
import '../screens/user_profile_page.dart';
import '../services/user_repository.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchTap;

  const CustomAppBar({super.key, this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    final user = UserRepository.currentUser;
    final hasImage = user?.profileImagePath != null &&
        user!.profileImagePath!.isNotEmpty &&
        File(user.profileImagePath!).existsSync();

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 2,
      centerTitle: true,

      title: Image.asset(
        'assets/images/Capa_1.png',
        height: 40,
      ),

      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserProfilePage()),
            );
          },
          child: CircleAvatar(
            radius: 18,
            backgroundImage: hasImage
                ? FileImage(File(user!.profileImagePath!))
                : const AssetImage('assets/images/profile_placeholder.png')
            as ImageProvider,
          ),
        ),
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black87),
          onPressed: onSearchTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
