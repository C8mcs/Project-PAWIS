class UserModel {
  final String? uid;

  UserModel({this.uid});
}

class UserDetailsModel {
  final String? uid;
  final String? fullname;
  final String? address;
  final String? phoneNumber;

  UserDetailsModel({this.uid, this.fullname, this.address, this.phoneNumber});
}
