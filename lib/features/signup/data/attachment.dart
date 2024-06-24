import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentUpload extends Equatable {
  final XFile localFile;
  final XFile? file;
  final String? url;
  final bool isUploading;
  final int progress;
  final AttachmentType type;

  const AttachmentUpload({
    required this.localFile,
    required this.type,
    this.file,
    this.url,
    this.isUploading = true,
    this.progress = 0,
  });

  AttachmentUpload copyWith({
    XFile? localFile,
    XFile? file,
    String? url,
    bool? isUploading,
    int? progress,
    AttachmentType? type,
  }) {
    return AttachmentUpload(
      localFile: localFile ?? this.localFile,
      file: file ?? this.file,
      url: url ?? this.url,
      isUploading: isUploading ?? this.isUploading,
      progress: progress ?? this.progress,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props =>
      [localFile, file, url, isUploading, progress, type];
}

enum AttachmentType { image, video }
