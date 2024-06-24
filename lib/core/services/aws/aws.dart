import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/services/aws/s3_file_upload_model.dart';
import 'package:turismo_rural_frontend/core/services/aws/upload_file.dart';

class AwsS3Service {
  final String accessKey;
  final String secretKey;
  final String region;
  final String bucketName;
  final String destDir;

  AwsS3Service({
    required this.accessKey,
    required this.secretKey,
    required this.region,
    required this.bucketName,
    required this.destDir,
  });

  Future<String?> uploadImageToS3({
    required XFile file,
    required Function(int) onProgress,
  }) async {
    try {
      if (accessKey.isEmpty ||
          secretKey.isEmpty ||
          region.isEmpty ||
          bucketName.isEmpty) {
        throw Exception("AWS S3 credentials and parameters must not be empty.");
      }

      final sanitizedFilename = _sanitizeFilename(file.name);
      final String filename =
          "${DateTime.now().millisecondsSinceEpoch}-$sanitizedFilename";

      final String uploadUrl =
          'https://$bucketName.s3.$region.amazonaws.com/$destDir/$filename';

      final fileBytes = await file.readAsBytes();
      if (fileBytes.isEmpty) {
        throw Exception("File error.");
      }

      final S3UploadModel config = S3UploadModel(
        s3UploadUrl: 'https://$bucketName.s3.$region.amazonaws.com/',
        s3SecretKey: secretKey,
        s3Region: region,
        s3AccessKey: accessKey,
        s3BucketName: bucketName,
        folderName: destDir,
        fileName: filename,
        fileBytes: fileBytes,
      );

      await AWSWebClient.uploadFile(
        config: config,
        onProgress: onProgress,
      );

      return uploadUrl;
    } catch (e) {
      return null;
    }
  }

  String _sanitizeFilename(String filename) {
    return filename
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_\-\.]'), '');
  }
}
