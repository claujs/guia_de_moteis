import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/guia_de_moteis_provider.dart';
import '../widgets/guia_de_moteis_card.dart';
import '../widgets/guia_de_moteis_body.dart';

class GuiaDeMoteisListPage extends ConsumerWidget {
  const GuiaDeMoteisListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guiaDeMoteisNotifierProvider);

    if (state.isLoading) {
      return const GuiaDeMoteisBody(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return GuiaDeMoteisBody(
        child: Center(child: Text(state.error!)),
      );
    }

    final guias = state.data?.guias ?? [];

    return GuiaDeMoteisBody(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: guias.length,
        itemBuilder: (context, index) {
          final guia = guias[index];
          return GuiaDeMoteisCard(
            guia: guia,
            globalRating: guia.media,
            globalReviews: guia.qtdAvaliacoes,
            quantity: guia.suites?.first.qtd ?? 0,
            items: guia.suites?.first.categoriaItens ?? [],
          );
        },
      ),
    );
  }
}
