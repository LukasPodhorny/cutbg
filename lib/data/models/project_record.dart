import 'package:equatable/equatable.dart';

enum BackgroundType { transparent, color, image }

/// Jeden uložený projekt = řádek tabulky `projects`.
class ProjectRecord extends Equatable {
  const ProjectRecord({
    required this.id,
    required this.createdAt,
    required this.originalImagePath,
    required this.maskImagePath,
    this.backgroundType = BackgroundType.transparent,
    this.backgroundValue,
    this.featherValue = 0,
  });

  final String id;
  final DateTime createdAt;
  final String originalImagePath;
  final String maskImagePath;
  final BackgroundType backgroundType;
  final String? backgroundValue;
  final double featherValue;

  Map<String, Object?> toMap() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'original_image_path': originalImagePath,
        'mask_image_path': maskImagePath,
        'background_type': backgroundType.name,
        'background_value': backgroundValue,
        'feather_value': featherValue,
      };

  factory ProjectRecord.fromMap(Map<String, Object?> map) => ProjectRecord(
        id: map['id']! as String,
        createdAt: DateTime.parse(map['created_at']! as String),
        originalImagePath: map['original_image_path']! as String,
        maskImagePath: map['mask_image_path']! as String,
        backgroundType: BackgroundType.values.byName(
          map['background_type']! as String,
        ),
        backgroundValue: map['background_value'] as String?,
        featherValue: (map['feather_value']! as num).toDouble(),
      );

  @override
  List<Object?> get props => [
        id,
        createdAt,
        originalImagePath,
        maskImagePath,
        backgroundType,
        backgroundValue,
        featherValue,
      ];
}
