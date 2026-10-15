import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Vykreslení vrstev editoru: originál + maska + tahy štětcem.
/// (Pokročilá funkce z návrhu: CustomPainter.)
class MaskPainter extends CustomPainter {
  const MaskPainter({this.original, this.mask, this.strokes = const []});

  final ui.Image? original;
  final Uint8List? mask;
  final List<BrushStroke> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: nakreslit originál, aplikovat masku, přikreslit tahy.
  }

  @override
  bool shouldRepaint(covariant MaskPainter oldDelegate) =>
      oldDelegate.original != original ||
      oldDelegate.mask != mask ||
      oldDelegate.strokes != strokes;
}

/// Jeden tah štětcem / gumou po masce.
class BrushStroke {
  const BrushStroke({
    required this.points,
    this.erase = false,
    this.width = 24,
  });

  final List<Offset> points;
  final bool erase;
  final double width;
}
