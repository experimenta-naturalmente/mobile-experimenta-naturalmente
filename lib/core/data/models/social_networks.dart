import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class SocialNetworks extends Equatable {
  final String? instagram;
  final String? facebook;
  final String? whatsapp;

  const SocialNetworks({
    this.instagram,
    this.facebook,
    this.whatsapp,
  });

  factory SocialNetworks.fromJson(Map<String, dynamic> json) {
    return SocialNetworks(
      instagram: decodeUtf8(json['instagram'] as String),
      facebook: decodeUtf8(json['facebook'] as String),
      whatsapp: decodeUtf8(json['whatsapp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'facebook': facebook,
      'whatsapp': whatsapp,
    };
  }

  @override
  List<Object?> get props => [instagram, facebook, whatsapp];
}
