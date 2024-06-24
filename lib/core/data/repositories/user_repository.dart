import 'dart:convert';
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
    await Future.delayed(const Duration(seconds: 2));
    final url = Uri.parse('https://dummyjson.com/auth/login');

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      final user = User(
        id: responseData['id'] as int,
        name: responseData['username'] as String,
        email: responseData['email'] as String,
        cpf: '9201934098',
        phone: '9201934098',
      );
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }
}
