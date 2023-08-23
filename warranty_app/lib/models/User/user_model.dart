import 'package:warranty_app/utils/User/user_role.dart';

class User {
  final String _userId;
  final String _userName;
  final int _contact;
  final UserRole _role;

  const User(
      {required String userId,
      required String userName,
      required int contact,
      required UserRole role})
      : _userId = userId,
        _userName = userName,
        _contact = contact,
        _role = role;
  get userId => _userId;

  get userName => _userName;

  get contact => _contact;

  get role => _role;
}
