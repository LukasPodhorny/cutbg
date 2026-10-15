import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/api/bg_removal_api.dart';

enum EditorStatus { idle, loading, ready, failure }

sealed class EditorEvent extends Equatable {
  const EditorEvent();

  @override
  List<Object?> get props => [];
}

/// Uživatel vybral fotku → poslat na server pro masku.
final class EditorImagePicked extends EditorEvent {
  const EditorImagePicked(this.imageBytes);

  final Uint8List imageBytes;

  @override
  List<Object?> get props => [imageBytes];
}

/// Posuvník vyhlazení okrajů (feather).
final class EditorFeatherChanged extends EditorEvent {
  const EditorFeatherChanged(this.value);

  final double value;

  @override
  List<Object?> get props => [value];
}

final class EditorReset extends EditorEvent {
  const EditorReset();
}

final class EditorState extends Equatable {
  const EditorState({
    this.status = EditorStatus.idle,
    this.original,
    this.mask,
    this.feather = 0,
    this.error,
  });

  final EditorStatus status;
  final Uint8List? original;
  final Uint8List? mask;
  final double feather;
  final String? error;

  EditorState copyWith({
    EditorStatus? status,
    Uint8List? original,
    Uint8List? mask,
    double? feather,
    String? error,
  }) =>
      EditorState(
        status: status ?? this.status,
        original: original ?? this.original,
        mask: mask ?? this.mask,
        feather: feather ?? this.feather,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, original, mask, feather, error];
}

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc({required BgRemovalApi api})
      : _api = api,
        super(const EditorState()) {
    on<EditorImagePicked>(_onImagePicked);
    on<EditorFeatherChanged>(_onFeatherChanged);
    on<EditorReset>((event, emit) => emit(const EditorState()));
  }

  final BgRemovalApi _api;

  Future<void> _onImagePicked(
    EditorImagePicked event,
    Emitter<EditorState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EditorStatus.loading,
        original: event.imageBytes,
      ),
    );
    try {
      final mask = await _api.removeBackground(event.imageBytes);
      emit(state.copyWith(status: EditorStatus.ready, mask: mask));
    } on BgRemovalException catch (e) {
      emit(state.copyWith(status: EditorStatus.failure, error: e.message));
    }
  }

  void _onFeatherChanged(
    EditorFeatherChanged event,
    Emitter<EditorState> emit,
  ) {
    emit(state.copyWith(feather: event.value));
  }
}
