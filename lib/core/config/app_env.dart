import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Typovaný přístup k `.env` (šablona: `.env.example`).
abstract final class AppEnv {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';

  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static int get maxImageSide =>
      int.tryParse(dotenv.env['MAX_IMAGE_SIDE'] ?? '') ?? 4096;

  static String get exportQuality =>
      dotenv.env['EXPORT_DEFAULT_QUALITY'] ?? 'original';
}
