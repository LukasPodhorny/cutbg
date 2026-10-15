import 'package:flutter/material.dart';

import '../../editor/view/editor_page.dart';

/// Domovská obrazovka: mřížka rozpracovaných projektů + import nové fotky.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CutBG')),
      body: const Center(
        child: Text('Zatím tu nic není.\nKlepni na + a vyber fotku.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _importPhoto(context),
        tooltip: 'Nová fotka',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _importPhoto(BuildContext context) async {
    // TODO: MediaService.pickFromGallery/Camera -> preprocessImage -> Editor.
    if (!context.mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const EditorPage()),
    );
  }
}
