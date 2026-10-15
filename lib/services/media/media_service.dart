import 'package:image_picker/image_picker.dart';

/// Import fotky z galerie / fotoaparátu.
class MediaService {
  MediaService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<XFile?> pickFromGallery() =>
      _picker.pickImage(source: ImageSource.gallery);

  Future<XFile?> pickFromCamera() =>
      _picker.pickImage(source: ImageSource.camera);
}
