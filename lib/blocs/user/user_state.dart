import '../../models/user_model.dart';

abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  final bool hasMore;
  UserLoaded(this.users, {this.hasMore = true});
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}