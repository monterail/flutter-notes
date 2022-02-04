part of 'notes_list_bloc.dart';

abstract class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesListEvent {}
