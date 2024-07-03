import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Address extends Equatable {
  final String street;
  final int number;
  final String zipCode;

  const Address({
    required this.street,
    required this.number,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: decodeUtf8(json['street'] as String),
      number: json['number'] as int,
      zipCode: decodeUtf8(json['zipCode'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
    };
  }

  @override
  List<Object?> get props => [street, number, zipCode];
}
