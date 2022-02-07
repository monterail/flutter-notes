import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 100)
class Note extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime creation;

  const Note({
    required this.id,
    this.content = '',
    required this.creation,
  });

  @override
  List<Object?> get props => [id, content];

  Note copyWith({
    int? id,
    String? content,
    DateTime? creation,
  }) =>
      Note(
        id: id ?? this.id,
        content: content ?? this.content,
        creation: creation ?? this.creation,
      );
}
