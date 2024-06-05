import 'dart:typed_data';

class PickedFileData {
  final Uint8List? bytes;
  final String? path;

  PickedFileData({this.bytes, this.path});
}
