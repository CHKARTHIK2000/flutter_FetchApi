import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/api_service.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'screens/user_list_screen.dart';


void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),


      home: BlocProvider(
        create: (_) => UserBloc(ApiService())..add(FetchUsersEvent()),
        child: const UserListScreen(),

        
      ),
    );
  }
}
