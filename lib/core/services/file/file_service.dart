import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/services/file/picked_file_data.dart';

class FileService {
  Future<PickedFileData?> pickImage() async {
    if (kIsWeb) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        final Uint8List? fileBytes = result.files.single.bytes;
        final String fileName = result.files.single.name;

        if (fileBytes != null) {
          return PickedFileData(bytes: fileBytes, path: fileName);
        }
      }
      return null;
    } else {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return PickedFileData(path: pickedFile.path);
      }
      return null;
    }
  }
}
