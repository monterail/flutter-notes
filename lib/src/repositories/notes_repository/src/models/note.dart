import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 100)
class Note extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String content;

  const Note({
    required this.id,
    this.content = '',
  });

  @override
  List<Object?> get props => [id, content];

  Note copyWith({
    int? id,
    String? content,
  }) =>
      Note(
        id: id ?? this.id,
        content: content ?? this.content,
      );
}
