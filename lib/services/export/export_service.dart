import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

/// Uložení hotového exportu do galerie a sdílení.
class ExportService {
  const ExportService();

  Future<void> saveToGallery(String filePath) => Gal.putImage(filePath);

  Future<void> shareFile(String filePath) =>
      SharePlus.instance.share(ShareParams(files: [XFile(filePath)]));
}
