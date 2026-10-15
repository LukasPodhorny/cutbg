import 'package:equatable/equatable.dart';

/// Jeden řádek tabulky `user_settings` (single record, id = 1).
class UserSettings extends Equatable {
  const UserSettings({
    this.exportQuality = 'original',
    this.themeMode = 'system',
  });

  final String exportQuality;
  final String themeMode;

  Map<String, Object?> toMap() => {
        'id': 1,
        'export_quality': exportQuality,
        'theme_mode': themeMode,
      };

  factory UserSettings.fromMap(Map<String, Object?> map) => UserSettings(
        exportQuality: map['export_quality'] as String? ?? 'original',
        themeMode: map['theme_mode'] as String? ?? 'system',
      );

  @override
  List<Object?> get props => [exportQuality, themeMode];
}
