import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:dio/dio.dart';
import 'package:turismo_rural_frontend/core/services/aws/s3_file_upload_model.dart';

class AWSWebClient {
  const AWSWebClient();

  static Future<void> uploadFile({
    required S3UploadModel config,
    required void Function(int) onProgress,
  }) async {
    final length = config.fileBytes.length;

    final dio = Dio();

    final headers = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
    };

    final uri = config.s3UploadUrl;

    final datetime = SigV4.generateDatetime();
    final expiration = DateTime.now()
        .add(const Duration(minutes: 15))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final credential =
        '${config.s3AccessKey}/${SigV4.buildCredentialScope(datetime, config.s3Region, 's3')}';
    final policy = '''
    { "expiration": "$expiration",
      "conditions": [
        {"bucket": "${config.s3BucketName}"},
        ["starts-with", "\$key", "${config.folderName}/${config.fileName}"],
        {"acl": "public-read"},
        ["content-length-range", 1, $length],
        {"x-amz-credential": "$credential"},
        {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
        {"x-amz-date": "$datetime" }
      ]
    }
    ''';
    final encodedPolicy = base64.encode(utf8.encode(policy));
    final key = SigV4.calculateSigningKey(
      config.s3SecretKey,
      datetime,
      config.s3Region,
      's3',
    );
    final signature = SigV4.calculateSignature(key, encodedPolicy);

    final formData = FormData.fromMap({
      'key': '${config.folderName}/${config.fileName}',
      'acl': 'public-read',
      'X-Amz-Credential': credential,
      'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
      'X-Amz-Date': datetime,
      'Policy': encodedPolicy,
      'X-Amz-Signature': signature,
      'file': MultipartFile.fromBytes(
        config.fileBytes,
        filename: config.fileName,
      ),
    });

    try {
      await dio.post(
        uri,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: (int sent, int total) {
          final progress = ((sent / total) * 100).round();
          onProgress(progress);
        },
      );
      print('${config.fileName} uploaded to s3Bucket');
    } catch (e) {
      print('Failed to upload file: $e');
    }
  }
}
