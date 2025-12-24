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
      instagram: json['instagram'] != null
          ? decodeUtf8(json['instagram'] as String)
          : null,
      facebook: json['facebook'] != null
          ? decodeUtf8(json['facebook'] as String)
          : null,
      whatsapp: json['whatsapp'] != null
          ? decodeUtf8(json['whatsapp'] as String)
          : null,
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
