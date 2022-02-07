part of 'note_edit_bloc.dart';

abstract class NoteEditEvent extends Equatable {
  const NoteEditEvent();

  @override
  List<Object?> get props => [];
}

class LoadNote extends NoteEditEvent {
  final int? noteId;

  const LoadNote(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

class UpdateContent extends NoteEditEvent {
  final String content;

  const UpdateContent(this.content);

  @override
  List<Object?> get props => [content];
}

class StoreNote extends NoteEditEvent {}

class DeleteNote extends NoteEditEvent {}
