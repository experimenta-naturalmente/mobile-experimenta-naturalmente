import 'dart:typed_data';

class S3UploadModel {
  final String s3UploadUrl;
  final String s3SecretKey;
  final String s3Region;
  final String s3AccessKey;
  final String s3BucketName;
  final String folderName;
  final String fileName;
  final Uint8List fileBytes;

  S3UploadModel({
    required this.s3UploadUrl,
    required this.s3SecretKey,
    required this.s3Region,
    required this.s3AccessKey,
    required this.s3BucketName,
    required this.folderName,
    required this.fileName,
    required this.fileBytes,
  });
}
