import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Předzpracování fotky: oprava orientace dle EXIF a zmenšení na [maxSide].
/// Těžká práce běží v Isolatu přes [compute], aby se nesekalo UI.
Future<Uint8List> preprocessImage(Uint8List bytes, {int maxSide = 4096}) =>
    compute(_preprocess, _PreprocessArgs(bytes, maxSide));

class _PreprocessArgs {
  const _PreprocessArgs(this.bytes, this.maxSide);
  final Uint8List bytes;
  final int maxSide;
}

Uint8List _preprocess(_PreprocessArgs args) {
  final decoded = img.decodeImage(args.bytes);
  if (decoded == null) {
    throw ArgumentError('Nepodporovaný formát obrázku.');
  }
  var fixed = img.bakeOrientation(decoded);
  final longest = fixed.width > fixed.height ? fixed.width : fixed.height;
  if (longest > args.maxSide) {
    final scale = args.maxSide / longest;
    fixed = img.copyResize(
      fixed,
      width: (fixed.width * scale).round(),
      height: (fixed.height * scale).round(),
    );
  }
  return img.encodeJpg(fixed);
}
