import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/todo_model.dart';

class ApiService {
  static const baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({int limit = 10, int skip = 0, String search = ''}) async {
    final url = search.isNotEmpty
        ? Uri.parse('$baseUrl/users/search?q=$search')
        : Uri.parse('$baseUrl/users?limit=$limit&skip=$skip');

    final res = await http.get(url);
    if (res.statusCode == 200) {
      final jsonData = json.decode(res.body);
      return (jsonData['users'] as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Post>> fetchPosts(int userId) async {
    final res = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['posts'] as List).map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Todo>> fetchTodos(int userId) async {
    final res = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['todos'] as List).map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
