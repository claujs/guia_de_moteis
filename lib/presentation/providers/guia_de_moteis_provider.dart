// lib/presentation/providers/guia_de_moteis_provider.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../core/error/failures.dart';
import '../../core/inject/inject.dart';
import '../../domain/entities/guia_de_moteis_response.dart';
import '../../domain/usecases/get_guia_de_moteis.dart';

class GuiaDeMoteisState {
  final bool isLoading;
  final GuiasDeMoteisResponse? data;
  final String? error;

  GuiaDeMoteisState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  GuiaDeMoteisState copyWith({
    bool? isLoading,
    GuiasDeMoteisResponse? data,
    String? error,
  }) {
    return GuiaDeMoteisState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}

class GuiaDeMoteisNotifier extends StateNotifier<GuiaDeMoteisState> {
  final GetGuiasDeMoteis getGuiasUseCase;

  GuiaDeMoteisNotifier({required this.getGuiasUseCase})
      : super(GuiaDeMoteisState()) {
    fetchGuias();
  }

  Future<void> fetchGuias() async {
    state = state.copyWith(isLoading: true, error: null);
    final Either<Failure, GuiasDeMoteisResponse> result =
        await getGuiasUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: AppStrings.erroBuscarDados, // Mensagem de erro atualizada
      ),
      (response) => state = state.copyWith(
        isLoading: false,
        data: response,
      ),
    );
  }
}

/// Provider do StateNotifier
final guiaDeMoteisNotifierProvider =
    StateNotifierProvider<GuiaDeMoteisNotifier, GuiaDeMoteisState>((ref) {
  final useCase = getIt<GetGuiasDeMoteis>();
  return GuiaDeMoteisNotifier(getGuiasUseCase: useCase);
});
