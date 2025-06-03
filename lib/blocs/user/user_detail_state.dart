import '../../models/post_model.dart';
import '../../models/todo_model.dart';
import 'package:flutter_app/models/user_model.dart'; // Adjust this path


abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final List<Post> posts;
  final List<Todo> todos;
  UserDetailLoaded({required this.posts, required this.todos});
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);
}
