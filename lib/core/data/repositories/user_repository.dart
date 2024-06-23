import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/core/data/interfaces/i_user_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';

class UserRepository implements IUserRepository {
  // THIS IS THE LINE
  //AwsS3Service awsS3Service;
  String apiUrl;

  UserRepository({required this.apiUrl});

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<User> getUserById(int userId) async {
    final response = await http.get(
      Uri.parse(
        '$apiUrl/users/$userId',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<Set<Spot>> fetchSpotsByProfileId(int profileId) async {
    final response = await http.get(
      Uri.parse(
        '$apiUrl/spot/spotsby/$profileId',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          json.decode(response.body) as List<dynamic>;
      final spots = spotsJson
          .map((json) => Spot.fromJsonProfile(json as Map<String, dynamic>))
          .toSet();

      print(spots);
      return spots;
    } else if (response.statusCode == 404) {
      return {};
    } else {
      throw Exception('Failed to load spots');
    }
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<User> loginUser(String username, String password) async {
    // URL da API de login
    final url = Uri.parse('https://dummyjson.com/auth/login');
    // final response = await http.get(
    //   Uri.parse(
    //     '$apiUrl/auth',
    //   ),
    // );

    // Corpo da requisição
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    // Fazendo a requisição POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      final user = User(
        // ignore: avoid_dynamic_calls
        id: responseData['id'] as int,
        // ignore: avoid_dynamic_calls
        name: responseData['username'] as String,
        // ignore: avoid_dynamic_calls
        email: responseData['email'] as String,
        cpf:
            '9201934098', // Default or empty value since not provided by the API
        phone:
            '9201934098', // Default or empty value since not provided by the API
      );
      return user;
    } else {
      throw Exception('Failed to login');
    }
  }
}
