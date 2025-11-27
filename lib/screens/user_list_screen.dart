
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';
import '../model/user_model.dart';
import 'user_detail_screen.dart';

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

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const Text(
          "Users",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar Neumorphic
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: neuBox(radius: 20),
              child: TextField(
                onChanged: (v) => setState(() => _query = v.toLowerCase()),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search users...",
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is UserError) {
                    return Center(child: Text("Error: ${state.msg}"));
                  }

                  if (state is UserLoaded) {
                    final users = state.users.where((u) {
                      return u.name.toLowerCase().contains(_query) ||
                             u.email.toLowerCase().contains(_query);
                    }).toList();

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 18),
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final initial = user.name[0].toUpperCase();

                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserDetailScreen(user: user),
                              ),
                            );
                          },

                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: neuBox(radius: 20),
                            child: Row(
                              children: [
                                // Avatar Neumorphic
                                Container(
                                  width: 55,
                                  height: 55,
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
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 18),

                                // Name + email
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        user.email,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(Icons.chevron_right, color: Colors.black45),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
