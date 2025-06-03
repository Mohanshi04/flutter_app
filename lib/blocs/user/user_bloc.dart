import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../services/api_service.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  int skip = 0;
  final int limit = 10;
  bool hasMore = true;
  List<User> users = [];

  UserBloc(this.apiService) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearch);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (event.isRefresh) {
      skip = 0;
      users.clear();
      hasMore = true;
    }
    if (!hasMore) return;
    emit(UserLoading());
    try {
      final newUsers = await apiService.fetchUsers(limit: limit, skip: skip);
      hasMore = newUsers.length == limit;
      skip += limit;
      users.addAll(newUsers);
      emit(UserLoaded(users, hasMore: hasMore));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onSearch(SearchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final searchedUsers = await apiService.fetchUsers(search: event.query);
      emit(UserLoaded(searchedUsers, hasMore: false));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

