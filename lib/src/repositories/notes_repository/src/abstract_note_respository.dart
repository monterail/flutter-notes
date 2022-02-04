import 'models/note.dart';

abstract class AbstractNoteRepository {
  Future<List<Note>> listAll();
  Future<int> get count;
  Future<Note?> getById(int id);
  Future<void> applyUpdate(Note note);
}
