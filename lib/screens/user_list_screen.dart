import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../models/user_model.dart';
import 'user_detail_screen.dart';

// class UserListScreen extends StatelessWidget {


class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search users",

                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<UserBloc>().add(FetchUsers(isRefresh: true));
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        context.read<UserBloc>().add(SearchUsers(_searchController.text));
                      },
                    ),
                  ],
                ),

              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading && context.read<UserBloc>().users.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserError) {
                  return Center(child: Text(state.message));
                } else if (state is UserLoaded){ //|| context.read<UserBloc>().users.isNotEmpty) {
                  // final users = context.read<UserBloc>().users;
                  final users = state.users;
                  return ListView.builder(
                    controller: _scrollController
                      ..addListener(() {
                        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && context.read<UserBloc>().hasMore) {
                          context.read<UserBloc>().add(FetchUsers());
                        }
                      }),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
                        title: Text(user.fullName),
                        subtitle: Text(user.email),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}

