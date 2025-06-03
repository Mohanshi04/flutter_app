import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_detail_bloc.dart';
import '../blocs/user/user_detail_event.dart';
import '../blocs/user/user_detail_state.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'create_post_screen.dart';


class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserDetailBloc(ApiService())..add(FetchUserDetail(user.id)),
      child: Scaffold(
        appBar: AppBar(title: Text(user.fullName)),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CircleAvatar(radius: 40, backgroundImage: NetworkImage(user.image)),
              const SizedBox(height: 8),
              Text(user.email, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<UserDetailBloc, UserDetailState>(
                  builder: (context, state) {
                    if (state is UserDetailLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is UserDetailLoaded) {
                      return DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(tabs: [
                              Tab(text: 'Posts (${state.posts.length})'),
                              Tab(text: 'Todos (${state.todos.length})'),
                            ]),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  ListView.builder(
                                    itemCount: state.posts.length,
                                    itemBuilder: (_, i) {
                                      final post = state.posts[i];
                                      return ListTile(
                                        title: Text(post.title),
                                        subtitle: Text(post.body),
                                      );
                                    },
                                  ),
                                  ListView.builder(
                                    itemCount: state.todos.length,
                                    itemBuilder: (_, i) {
                                      final todo = state.todos[i];
                                      return ListTile(
                                        title: Text(todo.todo),
                                        trailing: Icon(
                                          todo.completed ? Icons.check_circle : Icons.circle_outlined,
                                          color: todo.completed ? Colors.green : Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is UserDetailError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePostScreen(userId: user.id)),
            );
            if (result == true) {
              context.read<UserDetailBloc>().add(FetchUserDetail(user.id)); // refresh after post
            }
          },
        ),
      ),
    );
  }
}
