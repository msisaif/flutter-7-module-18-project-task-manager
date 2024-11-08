import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/profile_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    final userPhoto = AuthController.userData!.photo!.isNotEmpty
        ? Image.memory(
            base64Decode(AuthController.userData!.photo!),
            fit: BoxFit.cover,
          )
        : const Icon(Icons.person, color: Colors.grey);

    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: userPhoto,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userData?.fullName ?? '',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    AuthController.userData?.email ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (predicate) => false,
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
