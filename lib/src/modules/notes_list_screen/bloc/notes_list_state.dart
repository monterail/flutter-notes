part of 'notes_list_bloc.dart';

class NotesListState extends Equatable {
  final List<Note> notes;

  const NotesListState({
    this.notes = const [],
  });

  @override
  List<Object> get props => [notes];

  NotesListState copyWith({
    List<Note>? notes,
  }) =>
      NotesListState(
        notes: notes ?? this.notes,
      );
}
