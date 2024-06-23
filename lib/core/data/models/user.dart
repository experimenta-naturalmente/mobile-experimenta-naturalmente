import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String cpf;
  final String phone;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.phone,
  });

  @override
  List<Object?> get props => [id, name, email, cpf, phone];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['username'] as String,
      email: json['email'] as String,
      cpf: json['cpf'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }
}
