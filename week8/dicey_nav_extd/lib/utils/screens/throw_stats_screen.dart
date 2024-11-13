import 'screens_utils/screens_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ThrowStatsScreen extends ConsumerWidget {
  const ThrowStatsScreen(
      {super.key, required this.rowidx, required this.colidx});

  final String rowidx;
  final String colidx;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int row = int.tryParse(rowidx) ?? 1;
    int clipRow = row.clamp(1, 6);
    int col = int.tryParse(colidx) ?? 1;
    int clipCol = col.clamp(1, 6);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/visualization');
          },
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: TextDisplayMatrix(
        rowIdx: clipRow,
        colIdx: clipCol,
      ),
    );
  }
}
