import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';

part 'notes_list_event.dart';
part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  final AbstractNoteRepository _noteRepository;

  NotesListBloc({
    required AbstractNoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const NotesListState()) {
    on<LoadNotes>(_handleLoadNotes);
  }

  FutureOr<void> _handleLoadNotes(
    LoadNotes event,
    Emitter<NotesListState> emit,
  ) async {
    final notes = await _noteRepository.listAll();
    emit(state.copyWith(notes: notes));
  }
}
