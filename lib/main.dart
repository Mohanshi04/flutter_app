import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/user/user_bloc.dart';
import 'blocs/user/user_event.dart';
import 'services/api_service.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(const UserManagementApp());
}

class UserManagementApp extends StatelessWidget {
  const UserManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => UserBloc(ApiService())..add(FetchUsers()),
        child: UserListScreen(),
      ),
    );
  }
}


