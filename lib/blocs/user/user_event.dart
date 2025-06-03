abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final bool isRefresh;
  FetchUsers({this.isRefresh = false});
}

class SearchUsers extends UserEvent {
  final String query;

  SearchUsers(this.query);
}
