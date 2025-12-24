import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Attachment extends Equatable {
  final String url;
  final Uint8List? bytes;

  const Attachment({
    required this.url,
    this.bytes,
  });

  @override
  List<Object?> get props => [url, bytes];

  factory Attachment.fromJson(Map<String, dynamic> json) {
    Uint8List? decodedBytes;
    String decodedUrl = '';

    // Prefer explicit bytes/base64 field if present
    if (json['bytes'] != null) {
      final raw = json['bytes'];
      if (raw is String) {
        decodedBytes = base64Decode(raw);
      }
    }

    // Fallback: url field, which may itself be a data URI
    if (json['url'] != null) {
      final urlStr = decodeUtf8(json['url'] as String);
      decodedUrl = urlStr;
      if (decodedBytes == null && urlStr.startsWith('data:image')) {
        final parts = urlStr.split(',');
        if (parts.length == 2) {
          decodedBytes = base64Decode(parts[1]);
        }
      }
    }

    return Attachment(
      url: decodedUrl,
      bytes: decodedBytes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if (bytes != null) 'bytes': base64Encode(bytes!),
    };
  }

  bool get hasBytes => bytes != null && bytes!.isNotEmpty;
}
