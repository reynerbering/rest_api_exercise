import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/builder.dart';

part 'note_insert.g.dart';

@JsonSerializable()
class NoteManipulation {
  String? noteTitle;
  String? noteContent;

  NoteManipulation({
    required this.noteTitle,
    required this.noteContent,
  });

  Map<String, dynamic> toJson() => _$NoteManipulationToJson(this);
}
