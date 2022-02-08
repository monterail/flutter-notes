import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([
  AbstractNoteRepository,
])
void main() {
  final expectedNotes = List<Note>.generate(
    100,
    (index) => Note(id: index, creation: DateTime.now()),
  );
  blocTest<NotesListBloc, NotesListState>(
    'Loads notes into state',
    build: () {
      final mockNoteRepository = MockAbstractNoteRepository();
      when(mockNoteRepository.listAll())
          .thenAnswer((realInvocation) async => expectedNotes);
      return NotesListBloc(noteRepository: mockNoteRepository);
    },
    act: (bloc) => bloc.add(LoadNotes()),
    expect: () => [NotesListState(notes: expectedNotes)],
  );
}
