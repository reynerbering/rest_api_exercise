import 'package:rest_api_exercise/models/note_for_listing.dart';

class NotesService {
  List<NoteForListing> getNotesList() {
    return [
      NoteForListing(
          noteID: '1',
          noteTitle: 'Note 1',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
      NoteForListing(
          noteID: '2',
          noteTitle: 'Note 2',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
      NoteForListing(
          noteID: '3',
          noteTitle: 'Note 3',
          createDateTime: DateTime.now(),
          latestEditDateTime: DateTime.now()),
    ];
  }
}
