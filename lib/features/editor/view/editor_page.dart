import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../export/view/export_page.dart';
import '../bloc/editor_bloc.dart';

/// Hlavní editor: náhled + nástroje (štětec, okraje, pozadí).
class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        leading: IconButton(
          icon: const Icon(Icons.undo),
          tooltip: 'Krok zpět',
          // TODO: undo zásobník tahů štětce.
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const ExportPage()),
            ),
            child: const Text('Export'),
          ),
        ],
      ),
      body: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) {
          return switch (state.status) {
            EditorStatus.loading =>
              const Center(child: CircularProgressIndicator()),
            EditorStatus.failure =>
              Center(child: Text(state.error ?? 'Chyba zpracování.')),
            EditorStatus.ready =>
              const Center(child: Text('Náhled bez pozadí (TODO: vrstvy)')),
            EditorStatus.idle =>
              const Center(child: Text('Vyber fotku na domovské obrazovce.')),
          };
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {}, // TODO: panel štětce.
              icon: const Icon(Icons.brush),
              label: const Text('Štětec'),
            ),
            TextButton.icon(
              onPressed: () {}, // TODO: posuvník feather.
              icon: const Icon(Icons.blur_on),
              label: const Text('Okraje'),
            ),
            TextButton.icon(
              onPressed: () {}, // TODO: výběr pozadí.
              icon: const Icon(Icons.image),
              label: const Text('Pozadí'),
            ),
          ],
        ),
      ),
    );
  }
}
