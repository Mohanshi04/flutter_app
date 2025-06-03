abstract class UserDetailEvent {}

class FetchUserDetail extends UserDetailEvent {
  final int userId;
  FetchUserDetail(this.userId);
}

class AddLocalPost extends UserDetailEvent {
  final String title;
  final String body;

  AddLocalPost(this.title, this.body);
}


