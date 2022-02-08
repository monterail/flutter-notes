import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';
import 'package:template/src/services/share.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([
  AbstractNoteRepository,
  ShareService,
])
void main() {
  final expectedNotes = List<Note>.generate(
    100,
    (index) => Note(id: index, creation: DateTime.now()),
  );
  blocTest<NoteEditBloc, NoteEditState>(
    'Loads notes into state',
    build: () {
      final mockNoteRepository = MockAbstractNoteRepository();
      when(mockNoteRepository.getById(any)).thenAnswer((realInvocation) async =>
          expectedNotes[realInvocation.positionalArguments[0]]);
      return NoteEditBloc(
        noteRepository: mockNoteRepository,
        share: MockShareService(),
      );
    },
    act: (bloc) =>
        expectedNotes.map((note) => bloc.add(LoadNote(note.id))).toList(),
    wait: const Duration(seconds: 1),
    expect: () => expectedNotes
        .map<NoteEditState>((note) => NoteEditState(note: note))
        .toList(),
  );

  final initialNote = Note(
    id: 1000,
    content: 'initial content',
    creation: DateTime.now(),
  );
  const updatedContent = 'updated content';
  blocTest<NoteEditBloc, NoteEditState>(
    'Updates content',
    build: () => NoteEditBloc(
      noteRepository: MockAbstractNoteRepository(),
      share: MockShareService(),
    ),
    act: (bloc) => bloc.add(const UpdateContent(updatedContent)),
    seed: () => NoteEditState(note: initialNote),
    expect: () =>
        [NoteEditState(note: initialNote.copyWith(content: updatedContent))],
  );

  group(
    'Store note',
    () {
      final mockNoteRepository = MockAbstractNoteRepository();
      const storeInterval = Duration(milliseconds: 100);
      blocTest<NoteEditBloc, NoteEditState>(
        'Store event throttles calls to repository',
        build: () {
          when(mockNoteRepository.applyUpdate(any))
              .thenAnswer((realInvocation) async {});
          return NoteEditBloc(
            noteRepository: mockNoteRepository,
            share: MockShareService(),
            minStoreInterval: storeInterval,
          );
        },
        act: (bloc) =>
            List.generate(100, (_) => bloc.add(StoreNote())).toList(),
        seed: () => NoteEditState(note: initialNote),
        wait: storeInterval,
        expect: () {
          verify(mockNoteRepository.applyUpdate(any)).called(1);
          return [];
        },
      );
    },
  );

  group(
    'Delete note',
    () {
      final mockNoteRepository = MockAbstractNoteRepository();
      const noteIdToDelete = 100;
      blocTest<NoteEditBloc, NoteEditState>(
        'Calls repository to delete given note',
        build: () {
          when(mockNoteRepository.delete(noteIdToDelete))
              .thenAnswer((realInvocation) async {});
          return NoteEditBloc(
            noteRepository: mockNoteRepository,
            share: MockShareService(),
          );
        },
        act: (bloc) => [bloc.add(DeleteNote())],
        seed: () => NoteEditState(
            note: Note(id: noteIdToDelete, creation: DateTime.now())),
        wait: const Duration(seconds: 1),
        expect: () {
          verify(mockNoteRepository.delete(noteIdToDelete)).called(1);
          return [];
        },
      );
    },
  );

  group(
    'Share note',
    () {
      final mockShareService = MockShareService();
      const expectedContent = 'content';
      blocTest<NoteEditBloc, NoteEditState>(
        'Calls share service with note\'s content',
        build: () {
          when(mockShareService.share(expectedContent))
              .thenAnswer((realInvocation) async {});
          return NoteEditBloc(
            noteRepository: MockAbstractNoteRepository(),
            share: mockShareService,
          );
        },
        act: (bloc) => [bloc.add(ShareNote())],
        seed: () => NoteEditState(
            note: Note(
          id: 100,
          content: expectedContent,
          creation: DateTime.now(),
        )),
        wait: const Duration(seconds: 1),
        expect: () {
          verify(mockShareService.share(expectedContent)).called(1);
          return [];
        },
      );
    },
  );
}
