import 'dart:convert';
import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final int attachmentId;
  final String url;

  const Attachment({
    required this.attachmentId,
    required this.url,
  });

  @override
  List<Object?> get props => [url];

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachmentId: json['attachmentId'] as int,
      url: utf8.decode((json['url'] as String).codeUnits),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attachmentId': attachmentId,
      'url': url,
    };
  }
}
