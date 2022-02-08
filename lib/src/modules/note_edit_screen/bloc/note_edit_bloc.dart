import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';
import 'package:template/src/services/share.dart';

part 'note_edit_event.dart';
part 'note_edit_state.dart';

class NoteEditBloc extends Bloc<NoteEditEvent, NoteEditState> {
  final AbstractNoteRepository _noteRepository;
  final ShareService _share;

  NoteEditBloc({
    required AbstractNoteRepository noteRepository,
    required ShareService share,
  })  : _noteRepository = noteRepository,
        _share = share,
        super(const NoteEditState()) {
    on<LoadNote>(_handleLoadNote);
    on<UpdateContent>(_handleUpdateContent);
    on<StoreNote>(
      _handleStoreNote,
      transformer: throttle(
        const Duration(milliseconds: 100),
        leading: false,
        trailing: true,
      ),
    );
    on<DeleteNote>(_handleDeleteNote);
    on<ShareNote>(_handleShareNote);
  }

  FutureOr<void> _handleLoadNote(
    LoadNote event,
    Emitter<NoteEditState> emit,
  ) async {
    final note = event.noteId != null
        ? await _noteRepository.getById(event.noteId!)
        : null;
    emit(state.copyWith(note: note ?? await _buildDefaultNote()));
  }

  FutureOr<void> _handleUpdateContent(
    UpdateContent event,
    Emitter<NoteEditState> emit,
  ) async {
    final currentNote = state.note ?? await _buildDefaultNote();
    final newNote = currentNote.copyWith(content: event.content);
    emit(state.copyWith(note: newNote));
    add(StoreNote());
  }

  FutureOr<void> _handleStoreNote(
    StoreNote event,
    Emitter<NoteEditState> emit,
  ) async {
    if (state.note == null) {
      return;
    }
    await _noteRepository.applyUpdate(state.note!);
  }

  FutureOr<void> _handleDeleteNote(
    DeleteNote event,
    Emitter<NoteEditState> emit,
  ) async {
    if (state.note == null) {
      return;
    }
    await _noteRepository.delete(state.note!.id);
  }

  FutureOr<void> _handleShareNote(
    ShareNote event,
    Emitter<NoteEditState> emit,
  ) async {
    if (state.note == null) {
      return;
    }
    await _share.share(state.note!.content);
  }

  Future<Note> _buildDefaultNote() async =>
      Note(id: await _noteRepository.count, creation: DateTime.now());
}
