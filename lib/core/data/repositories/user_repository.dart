import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/core/data/interfaces/i_user_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';

class UserRepository implements IUserRepository {
  Uri apiUri;

  UserRepository({required this.apiUri});

  @override
  Future<User> getUserById(int userId) async {
    final response = await http.get(
      apiUri.replace(path: 'users/$userId'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> loginUser(String username, String password) async {
    try {
      final userCredential = await firebase_auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('User not found');
      }

      return User(
        id: firebaseUser.uid.hashCode,
        name: firebaseUser.displayName ?? username,
        email: firebaseUser.email ?? '',
        cpf: '',
        phone: '',
      );
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
