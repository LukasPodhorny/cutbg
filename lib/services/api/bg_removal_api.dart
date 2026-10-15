import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../core/config/app_env.dart';

/// Klient bezstavového BiRefNet backendu (FastAPI na Modalu).
/// Server nic neukládá, vrací jen 8bitovou masku.
class BgRemovalApi {
  BgRemovalApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri(String path) => Uri.parse('${AppEnv.apiBaseUrl}$path');

  Map<String, String> get _headers => {
        if (AppEnv.apiKey.isNotEmpty) 'X-API-Key': AppEnv.apiKey,
      };

  /// Health check (pokryje i studený start serveru).
  Future<bool> isHealthy() async {
    final res = await _client.get(_uri('/v1/health'), headers: _headers);
    return res.statusCode == 200;
  }

  /// Pošle fotku, vrátí masku průhlednosti jako PNG bytes.
  Future<Uint8List> removeBackground(
    Uint8List imageBytes, {
    String filename = 'photo.jpg',
  }) async {
    final req = http.MultipartRequest('POST', _uri('/v1/remove-background'))
      ..headers.addAll(_headers)
      ..files.add(
        http.MultipartFile.fromBytes('file', imageBytes, filename: filename),
      );
    final res = await _client.send(req);
    final body = await res.stream.toBytes();
    if (res.statusCode != 200) {
      throw BgRemovalException('Server vrátil ${res.statusCode}.');
    }
    return body;
  }
}

class BgRemovalException implements Exception {
  const BgRemovalException(this.message);
  final String message;

  @override
  String toString() => 'BgRemovalException: $message';
}
