import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';
import '../../models/post_model.dart';
import '../../models/todo_model.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final ApiService apiService;
  UserDetailBloc(this.apiService) : super(UserDetailInitial()) {
    on<FetchUserDetail>(_onFetchUserDetail);

    on<AddLocalPost>((event, emit) {
      if (state is UserDetailLoaded) {
        final currentState = state as UserDetailLoaded;

        final newPost = Post(
          id: currentState.posts.length + 1, // simulate unique ID
          title: event.title,
          body: event.body,
        );


        final updatedPosts = List<Post>.from(currentState.posts)..insert(0, newPost);

        emit(UserDetailLoaded(
          posts: updatedPosts,
          todos: currentState.todos,
        ));
      }
    });
  }

  void _onFetchUserDetail(FetchUserDetail event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final posts = await apiService.fetchPosts(event.userId);
      final todos = await apiService.fetchTodos(event.userId);
      emit(UserDetailLoaded(posts: posts, todos: todos));
    } catch (e) {
      emit(UserDetailError(e.toString()));
    }
  }

}
