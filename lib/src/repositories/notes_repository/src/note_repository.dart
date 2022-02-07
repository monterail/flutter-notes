import 'abstract_note_respository.dart';
import 'models/note.dart';
import 'package:template/src/services/hive.dart';

class NoteRepository extends AbstractNoteRepository with IHiveRepository<Note> {
  @override
  String get boxKey => 'notes';

  @override
  Future<void> applyUpdate(Note note) async => (await box).put(note.id, note);

  @override
  Future<Note?> getById(int id) async => (await box).get(id);

  @override
  Future<List<Note>> listAll() async {
    final box = await this.box;
    return box.keys.map<Note>((key) => box.get(key)!).toList(growable: false);
  }

  @override
  Future<int> get count async => (await box).length;

  @override
  Future<void> delete(int id) async => (await box).delete(id);
}
