import 'package:flutter/material.dart';

/// Export: volba formátu PNG/JPEG + rozlišení, uložit / sdílet.
class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  var _format = 'PNG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'PNG', label: Text('PNG')),
                ButtonSegment(value: 'JPEG', label: Text('JPEG')),
              ],
              selected: {_format},
              onSelectionChanged: (selected) =>
                  setState(() => _format = selected.first),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              // TODO: vyrenderovat kompozici -> ExportService.saveToGallery.
              onPressed: () {},
              icon: const Icon(Icons.save_alt),
              label: const Text('Uložit do galerie'),
            ),
            TextButton.icon(
              // TODO: vyrenderovat kompozici -> ExportService.shareFile.
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('Sdílet'),
            ),
          ],
        ),
      ),
    );
  }
}
