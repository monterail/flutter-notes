part of 'note_edit_bloc.dart';

class NoteEditState extends Equatable {
  final Note? note;

  const NoteEditState({this.note});

  @override
  List<Object?> get props => [note];

  NoteEditState copyWith({Note? note}) =>
      NoteEditState(note: note ?? this.note);
}
