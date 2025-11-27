// lib/screens/user_detail_screen.dart
import 'package:flutter/material.dart';
import '../model/user_model.dart';

const background = Color.fromARGB(255, 255, 255, 255);
const cardColor  = Color(0xFFF0F6FF);
const avatarBg   = Color(0xFFD5E6FF);
const darkShadow = Color(0xFFB8C7DA);
const lightShadow = Color(0xFFFFFFFF);

BoxDecoration neuBox({double radius = 16}) {
  return BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: const [
      BoxShadow(
        color: darkShadow,
        offset: Offset(4, 4),
        blurRadius: 10,
      ),
      BoxShadow(
        color: lightShadow,
        offset: Offset(-4, -4),
        blurRadius: 10,
      ),
    ],
  );
}

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final initial = user.name[0].toUpperCase();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: avatarBg,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: darkShadow,
                    offset: Offset(4, 4),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: lightShadow,
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 30),

            // Info Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: neuBox(radius: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailItem(Icons.email_outlined, user.email),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget detailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
