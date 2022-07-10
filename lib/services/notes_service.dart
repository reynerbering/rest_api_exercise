import 'dart:convert';

import 'package:rest_api_exercise/models/api_response.dart';
import 'package:rest_api_exercise/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const api = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app/';
  static const headers = {'apiKey': 'a587489e-bf58-452a-89bb-80d8a7957837'};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$api/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
              noteID: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: DateTime.parse(item['createDateTime']),
              latestEditDateTime: item['latestEditDateTime' == null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : null]);
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occured'));
  }
}
