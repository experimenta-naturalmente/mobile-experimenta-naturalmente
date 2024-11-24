import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Attachment extends Equatable {
  final String url;

  const Attachment({
    required this.url,
  });

  @override
  List<Object?> get props => [url];

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      url: decodeUtf8(json['url'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
