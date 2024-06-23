import 'package:turismo_rural_frontend/core/data/models/user.dart';

abstract class IUserRepository<TUser> {
  Future<User> getUserById(int userId);
  Future<List<User>> getAllUsers();
  Future<void> updateUser(User user);
  Future<User> loginUser(String username, String password);
}
